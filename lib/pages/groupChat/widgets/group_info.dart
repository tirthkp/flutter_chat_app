import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/model/group_chat_model.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:flutter_chat_app/pages/Chat/chat_page.dart';
import 'package:flutter_chat_app/pages/groupChat/widgets/info_container.dart';
import 'package:flutter_chat_app/widgets/chat_tile.dart';
import 'package:get/get.dart';

class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(groupModel.name!),
          centerTitle: true,
          scrolledUnderElevation: 0,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10,
          bottom: 10,
          top: 25,
        ),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            InfoContainer(
              groupId: groupModel.id!,
              user: UserModel(),
              profileImage: groupModel.profileImage == '' ||
                      groupModel.profileImage == null
                  ? AssetsImage.groupImg
                  : groupModel.profileImage!,
              name: groupModel.name!,
              email:
                  groupModel.description == '' || groupModel.description == null
                      ? "Add description"
                      : groupModel.description!,
            ),
            const SizedBox(height: 20),
            Text("Group Members", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 5),
            ListView(
              shrinkWrap: true,
              children: groupModel.members!.map((e) {
                return ChatTile(
                    ontap: () {
                      Get.to(ChatPage(userModel: e));
                    },
                    title: e.name!,
                    imageUrl: e.profileImage == '' || e.profileImage == null
                        ? AssetsImage.userImg
                        : e.profileImage!,
                    subTitle: e.about == '' || e.about == null
                        ? "Hey there,I am using chat app"
                        : e.about!,
                    time: e.role == '' || e.role == null ? "" : e.role);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
