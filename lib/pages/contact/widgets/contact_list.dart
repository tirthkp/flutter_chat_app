import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/pages/Chat/chat_page.dart';
import 'package:get/get.dart';

import '../../../controller/chat_controller.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    return Obx(
      () => ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: contactController.userList
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Get.to(() => ChatPage(userModel: e),
                        transition: Transition.rightToLeft);
                    chatController.getRoomId(e.id!);
                  },
                  horizontalTitleGap: 15,
                  leading: e.profileImage != null && e.profileImage != ''
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(e.profileImage!),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(AssetsImage.userImg),
                            ),
                          ),
                        ),
                  title: Text(
                    e.name ?? 'User Name',
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    e.about != null && e.about != '' ? e.about! : "Hey there",
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  trailing: Text(
                    e.email == profileController.currentUser.value.email
                        ? 'You'
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
