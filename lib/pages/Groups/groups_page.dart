import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:get/get.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => ListView(
        children: groupController.groupList
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: ListTile(
                  onTap: () {},
                  horizontalTitleGap: 15,
                  leading: CachedNetworkImage(
                    imageUrl: e.profileImage == '' || e.profileImage == null
                        ? AssetsImage.groupImg
                        : e.profileImage!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    e.name ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    e.lastMessage == '' || e.lastMessage == null
                        ? 'Group chat'
                        : e.lastMessage!,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  trailing: Text(
                      e.lastMessageTime == null || e.lastMessageTime == ''
                          ? ''
                          : e.lastMessageTime!,
                      style: Theme.of(context).textTheme.bodyMedium),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
