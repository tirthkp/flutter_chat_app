import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/model/group_chat_model.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../model/chat_model.dart';

class GroupController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxList<UserModel> groupMembers = <UserModel>[].obs;
  var uuid = const Uuid();
  ImageController imagecontroller = Get.put(ImageController());
  ProfileController profileController = Get.put(ProfileController());
  RxBool isLoading = false.obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  RxString selectedImagePath = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getGroups();
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

    groupMembers.add(
      UserModel(
        id: auth.currentUser!.uid,
        name: profileController.currentUser.value.name,
        email: profileController.currentUser.value.email,
        profileImage: profileController.currentUser.value.profileImage,
        role: "Admin",
      ),
    );

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
      groupList.value = tempGroup.where((group) {
        final isCreator = group.createdBy == auth.currentUser!.uid;
        final isMember =
            group.members!.any((member) => member.id == auth.currentUser!.uid);
        return isCreator || isMember;
      }).toList();
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> sendGroupMessage(
      String message, String groupId, String imagePath) async {
    var chatId = uuid.v6();
    String imageUrl = await imagecontroller.uploadFileToFirebase(imagePath);
    var newChat = ChatModel(
      message: message,
      imageUrl: imageUrl,
      id: chatId,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timeStamp: DateTime.now().toString(),
      currentTime: DateFormat('HH:mm a').format(DateTime.now()),
    );

    await db
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(chatId)
        .set(newChat.toJson());
  }
}
