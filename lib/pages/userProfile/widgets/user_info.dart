import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/pages/userProfile/widgets/call_buttons.dart';
import 'package:get/get.dart';

import '../../../config/images.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset(AssetsImage.boyPic),
            const SizedBox(height: 20),
            Obx(
              () => Text(
                profileController.currentUser.value.name ?? 'User',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Obx(
              () => Text(
                profileController.currentUser.value.email!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CallButton(
                  icon: Icons.phone,
                  name: 'Call',
                  size: 30,
                  ontap: () {},
                ),
                CallButton(
                  icon: Icons.videocam,
                  name: 'Video',
                  size: 30,
                  ontap: () {},
                ),
                CallButton(
                  icon: Icons.chat_bubble,
                  name: 'Chat',
                  size: 25,
                  ontap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
