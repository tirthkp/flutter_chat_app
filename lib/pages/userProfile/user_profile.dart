import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/userProfile/widgets/user_info.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import '../../model/user_model.dart';

class UserProfile extends StatelessWidget {
  final UserModel userModel;
  const UserProfile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10,
          right: 10,
          bottom: 20,
        ),
        child: Column(
          children: [
            UserInfo(
              email: userModel.email!,
              name: userModel.name!,
              profileImage:
                  userModel.profileImage != null && userModel.profileImage != ''
                      ? userModel.profileImage!
                      : AssetsImage.userImg,
            )
          ],
        ),
      ),
    );
  }
}
