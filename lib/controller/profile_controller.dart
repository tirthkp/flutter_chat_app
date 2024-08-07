import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  ImageController imageController = Get.put(ImageController());
  RxBool isLoading = false.obs;

  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    isLoading.value = true;
    await db.collection("users").doc(auth.currentUser!.uid).get().then(
          (value) => {
            currentUser.value = UserModel.fromJson(value.data()!),
          },
        );
    isLoading.value = false;
  }

  Future<void> updateProfile(
    String imageUrl,
    String name,
    String about,
    String number,
    String email,
  ) async {
    isLoading.value = true;
    try {
      final imageLink = await imageController.uploadFileToFirebase(imageUrl);
      final updatedUser = UserModel(
        name: name,
        about: about,
        profileImage:
            imageUrl == '' ? currentUser.value.profileImage : imageLink,
        phoneNumber: number,
        email: auth.currentUser!.email,
        id: auth.currentUser!.uid,
      );
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(updatedUser.toJson());
      await getUserDetails();
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
  }
}
