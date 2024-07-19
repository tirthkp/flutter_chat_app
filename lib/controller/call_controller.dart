import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/call_model.dart';
import 'package:flutter_chat_app/pages/CallPage/audio_call_page.dart';
import 'package:flutter_chat_app/pages/CallPage/video_call.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../model/user_model.dart';

class CallController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = const Uuid().v6();

  @override
  void onInit() {
    super.onInit();
    getCallsNotification().listen((
      List<CallModel> callList,
    ) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        if (callData.type == 'audio') {
          audioCallNotification(callData);
        } else if (callData.type == 'video') {
          videoCallNotification(callData);
        }
      }
    });
  }

  Future<void> videoCallNotification(CallModel callData) async {
    Get.snackbar(
      callData.callerName!,
      'incoming video call',
      backgroundColor: Colors.grey,
      duration: const Duration(days: 1),
      barBlur: 0,
      isDismissible: false,
      icon: const Icon(Icons.videocam),
      onTap: (snack) {
        Get.back();
        Get.to(
          VideoCall(
            target: UserModel(
              id: callData.callerId,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
      },
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text('End Call'),
      ),
    );
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      callData.callerName!,
      'incoming audio call',
      backgroundColor: Colors.grey,
      duration: const Duration(days: 1),
      barBlur: 0,
      isDismissible: false,
      icon: const Icon(Icons.call),
      onTap: (snack) {
        Get.back();
        Get.to(
          AudioCallPage(
            target: UserModel(
              id: callData.callerId,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
      },
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text('End Call'),
      ),
    );
  }

  Future<void> callAction(
      UserModel receiver, UserModel caller, String type) async {
    String id = uuid;
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerEmail: caller.email,
      callerId: caller.id,
      receiverEmail: receiver.email,
      receiverName: receiver.name,
      receiverPic: receiver.profileImage,
      receiverId: receiver.id,
      status: "dialing",
      type: type,
      time: DateFormat('HH:mm a').format(DateTime.now()),
      timeStamp: DateTime.now().toString(),
    );

    try {
      await db
          .collection("notification")
          .doc(receiver.id)
          .collection('call')
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection('users')
          .doc(receiver.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      Future.delayed(const Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CallModel>> getCallsNotification() {
    String user = auth.currentUser!.uid;
    return db
        .collection('notification')
        .doc(user)
        .collection('call')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => CallModel.fromJson(e.data())).toList());
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection('notification')
          .doc(call.receiverId)
          .collection('call')
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CallModel>> getCalls() {
    return db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => CallModel.fromJson(e.data()),
              )
              .toList(),
        );
  }
}
