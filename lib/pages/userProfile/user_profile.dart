import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/userProfile/widgets/logout_button.dart';
import 'package:flutter_chat_app/pages/userProfile/widgets/user_info.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
      body: const Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          left: 10,
          right: 10,
          bottom: 20,
        ),
        child: Column(
          children: [
            UserInfo(),
            Spacer(),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}
