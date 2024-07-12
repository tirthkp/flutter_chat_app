import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/model/chat_model.dart';
import 'package:flutter_chat_app/model/chat_room_model.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../config/images.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  ProfileController profileController = Get.put(ProfileController());
  ImageController imageController = Get.put(ImageController());
  ContactController contactController = Get.put(ContactController());
  RxBool isLoading = false.obs;
  var uuid = const Uuid();
  RxString selectedImagePath = ''.obs;
  RxString imageUrl = ''.obs;

  String imgUrl(ChatRoomModel e) {
    if ((e.receiver!.id == profileController.currentUser.value.id
                ? e.sender!.profileImage
                : e.receiver!.profileImage) ==
            '' ||
        (e.receiver!.id == profileController.currentUser.value.id
                ? e.sender!.profileImage
                : e.receiver!.profileImage) ==
            null) {
      return AssetsImage.userImg;
    } else if ((e.receiver!.id == profileController.currentUser.value.id)) {
      return e.sender!.profileImage!;
    } else {
      return e.receiver!.profileImage!;
    }
  }

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);

    UserModel sender =
        getSender(profileController.currentUser.value, targetUser);
    UserModel receiver =
        getReceiver(profileController.currentUser.value, targetUser);

    if (selectedImagePath.value != '') {
      String path = selectedImagePath.value;
      selectedImagePath.value = '';
      imageUrl.value = await imageController.uploadFileToFirebase(path);
    }
    var newChat = ChatModel(
      message: message,
      imageUrl: imageUrl.value,
      id: chatId,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timeStamp: DateTime.now().toString(),
      currentTime: DateFormat('HH:mm a').format(DateTime.now()),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTime: DateFormat('HH:mm a').format(DateTime.now()),
      sender: sender,
      receiver: receiver,
      unreadMessageNo: 0,
      timeStamp: DateTime.now().toString(),
    );
    try {
      await db.collection('chats').doc(roomId).set(
            roomDetails.toJson(),
          );
      await db
          .collection('chats')
          .doc(roomId)
          .collection('messages')
          .doc(chatId)
          .set(
            newChat.toJson(),
          );
      await contactController.saveContact(targetUser);
      imageUrl.value = '';
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection('chats')
        .doc(roomId)
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
}
