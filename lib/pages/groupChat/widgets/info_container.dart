import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:flutter_chat_app/widgets/call_buttons.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';

class InfoContainer extends StatelessWidget {
  final String profileImage;
  final String name;
  final String email;
  final String groupId;
  final UserModel user;

  const InfoContainer({
    super.key,
    required this.profileImage,
    required this.name,
    required this.email,
    required this.groupId,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
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
            CachedNetworkImage(
              imageUrl: profileImage,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CallButton(
                  icon: Icons.phone_outlined,
                  name: 'Call',
                  size: 30,
                  ontap: () {},
                  color: Colors.orange.withOpacity(0.5),
                ),
                CallButton(
                  icon: Icons.videocam_outlined,
                  name: 'Video',
                  size: 30,
                  ontap: () {},
                  color: Colors.blue.withOpacity(0.5),
                ),
                CallButton(
                  icon: Icons.person_add_alt_1_outlined,
                  name: 'Add',
                  size: 25,
                  ontap: () {
                    groupController.addMember(groupId, user);
                  },
                  color: Colors.green.withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
