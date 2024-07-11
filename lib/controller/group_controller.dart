import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:flutter_chat_app/model/group_chat_model.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  var uuid = const Uuid();
  ImageController imagecontroller = Get.put(ImageController());
  RxBool isLoading = false.obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    String groupId = uuid.v6();
    isLoading.value = true;

    try {
      String imageUrl = await imagecontroller.uploadFileToFirebase(imagePath);
      var newGroup = GroupModel(
        id: groupId,
        name: groupName,
        profileImage: imageUrl,
        createdAt: DateTime.now().toString(),
        createdBy: auth.currentUser!.uid,
        members: groupMembers.map((e) => e.toJson()).toList(),
        timeStamp: DateTime.now().toString(),
        description: '',
      );

      await db.collection("groups").doc(groupId).set(newGroup.toJson());
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    try {
      await db.collection('groups').get().then(
        (value) {
          tempGroup = value.docs
              .map(
                (e) => GroupModel.fromJson(e.data()),
              )
              .toList();
        },
      );
      groupList.clear();
      groupList.value = tempGroup
          .where(
            (e) => e.members!
                .any((element) => element.id == auth.currentUser!.uid),
          )
          .toList();
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}
