import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/chat_room_model.dart';

class HomeController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // RxBool isLoading = false.obs;
  // RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  // Future<void> getChatRoomList() async {
  //   List<ChatRoomModel> tempChatRoom = [];

  //   isLoading.value = true;
  //   try {
  //     await db
  //         .collection('chats')
  //         .orderBy('timeStamp', descending: true)
  //         .get()
  //         .then(
  //       (value) {
  //         tempChatRoom =
  //             value.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList();
  //       },
  //     );
  //     chatRoomList.value = tempChatRoom
  //         .where(
  //           (e) => e.id!.contains(auth.currentUser!.uid),
  //         )
  //         .toList();
  //     isLoading.value = false;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Stream<List<ChatRoomModel>> getChatList() {
    return db
        .collection('chats')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => ChatRoomModel.fromJson(e.data()))
          .where(
            (e) => e.id!.contains(auth.currentUser!.uid),
          )
          .toList();
    });
  }
}
