import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:flutter_chat_app/pages/Groups/newGroup/new_group.dart';
import 'package:flutter_chat_app/pages/groupChat/group_chat.dart';
import 'package:flutter_chat_app/widgets/chat_tile.dart';
import 'package:get/get.dart';

import '../Home/widgets/default_home_screen.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ContactController contactController = Get.put(ContactController());
    return StreamBuilder(
      stream: groupController.getGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: ChatTile(
                  title: snapshot.data![index].name ?? '',
                  imageUrl: snapshot.data![index].profileImage == '' ||
                          snapshot.data![index].profileImage == null
                      ? AssetsImage.groupImg
                      : snapshot.data![index].profileImage!,
                  subTitle: snapshot.data![index].lastMessage == '' ||
                          snapshot.data![index].lastMessage == null
                      ? 'Group chat'
                      : snapshot.data![index].lastMessage!,
                  time: snapshot.data![index].lastMessageTime == null ||
                          snapshot.data![index].lastMessageTime == ''
                      ? ''
                      : snapshot.data![index].lastMessageTime!,
                  ontap: () {
                    Get.to(() => GroupChat(
                          groupModel: snapshot.data![index],
                        ));
                  },
                ),
              );
            },
          );
        } else {
          return DefaultHomeScreen(
            text: 'No Groups here...',
            buttonText: 'New Group',
            onTap: () async {
              Get.to(() => const NewGroup());
              await contactController.getUserList();
            },
          );
        }
      },
    );
  }
}
