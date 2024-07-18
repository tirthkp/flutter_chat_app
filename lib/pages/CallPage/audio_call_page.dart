import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/strings.dart';
import 'package:flutter_chat_app/controller/chat_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatelessWidget {
  final UserModel target;
  const AudioCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    var callId = chatController.getRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
        appID: ZegoCloudConfig.appId,
        appSign: ZegoCloudConfig.appSign,
        callID: callId,
        userID: profileController.currentUser.value.id ?? "root",
        userName: profileController.currentUser.value.name ?? "root",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
