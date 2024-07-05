import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/model/chat_room_model.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxList<UserModel> userList = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();
      await db.collection('users').get().then(
            (value) => {
              userList.value = value.docs
                  .map(
                    (e) => UserModel.fromJson(
                      e.data(),
                    ),
                  )
                  .toList(),
            },
          );
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }
}
