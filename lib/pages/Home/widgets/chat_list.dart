import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/chat_controller.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/home_controller.dart';

import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:get/get.dart';

import '../../Chat/chat_page.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    ChatController chatController = Get.put(ChatController());
    HomeController homeController = Get.put(HomeController());
    ProfileController profileController = Get.put(ProfileController());
    return Obx(
      () => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: homeController.chatRoomList.map(
          (e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.to(
                      () => ChatPage(
                            userModel: e.receiver!.id ==
                                    profileController.currentUser.value.id
                                ? e.sender!
                                : e.receiver!,
                          ),
                      transition: Transition.rightToLeft);
                  chatController.getRoomId(e.id!);
                },
                horizontalTitleGap: 15,
                leading: e.receiver!.profileImage != null &&
                            e.receiver!.profileImage != '' ||
                        e.sender!.profileImage != null &&
                            e.sender!.profileImage != ''
                    ? Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                chatController.imgUrl(e),
                              ),
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
                  (e.receiver!.id == profileController.currentUser.value.id
                      ? e.sender!.name
                      : e.receiver!.name)!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                subtitle: Text(
                  e.lastMessage != null && e.lastMessage != ''
                      ? e.lastMessage!
                      : "Hey there",
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                tileColor: Theme.of(context).colorScheme.primaryContainer,
                trailing: Text(
                  e.receiver!.email == e.sender!.email
                      ? 'you'
                      : e.lastMessageTime!,
                  style: e.receiver!.email == e.sender!.email
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.labelMedium,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
