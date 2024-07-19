import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/chat_controller.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/home_controller.dart';

import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/pages/Home/widgets/default_home_screen.dart';
import 'package:flutter_chat_app/widgets/chat_tile.dart';
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
    ContactController contactController = Get.put(ContactController());
    return StreamBuilder(
      stream: homeController.getChatList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ChatTile(
                title: (snapshot.data![index].receiver!.id ==
                        profileController.currentUser.value.id
                    ? snapshot.data![index].sender!.name
                    : snapshot.data![index].receiver!.name)!,
                imageUrl: snapshot.data![index].receiver!.profileImage !=
                                null &&
                            snapshot.data![index].receiver!.profileImage !=
                                '' ||
                        snapshot.data![index].sender!.profileImage != null &&
                            snapshot.data![index].sender!.profileImage != ''
                    ? chatController.imgUrl(snapshot.data![index])
                    : AssetsImage.userImg,
                subTitle: snapshot.data![index].lastMessage != null &&
                        snapshot.data![index].lastMessage != ''
                    ? snapshot.data![index].lastMessage!
                    : "Hey there",
                time: snapshot.data![index].lastMessageTime ?? "",
                ontap: () {
                  Get.to(
                      () => ChatPage(
                            userModel: snapshot.data![index].receiver!.id ==
                                    profileController.currentUser.value.id
                                ? snapshot.data![index].sender!
                                : snapshot.data![index].receiver!,
                          ),
                      transition: Transition.rightToLeft);
                  chatController.getRoomId(snapshot.data![index].id!);
                },
              );
            },
          );
        } else {
          return DefaultHomeScreen(
              text: 'Start chatting...',
              onTap: () async {
                Get.toNamed('/contactPage');
                await contactController.getUserList();
              },
              buttonText: 'Contacts');
        }
      },
    );
  }
}
