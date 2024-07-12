// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxBool isLogin = true.obs;
  RxBool isVisible = true.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed('/homePage');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.code.replaceAll(RegExp(r'-'), ' '),
        backgroundColor: const Color(0xff0057ff),
        isDismissible: true,
        colorText: Colors.white,
      );
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
    isVisible.value = false;
  }

  Future<void> createUser(String name, String email, String password) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await initUser(email, name);
      Get.offAllNamed('/homePage');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.code.replaceAll(RegExp(r'-'), ' '),
        backgroundColor: const Color(0xff0057ff),
        isDismissible: true,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
    isLoading.value = false;
    isVisible.value = false;
  }

  Future<void> logoutUser() async {
    await auth.signOut();
    Get.offAllNamed('/authPage');
  }

  Future<void> initUser(String email, String name) async {
    var newUser = UserModel(
      email: email,
      name: name,
      id: auth.currentUser!.uid,
    );

    try {
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (e) {
      print(e);
    }
  }
}
