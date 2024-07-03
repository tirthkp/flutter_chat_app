import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
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
                    Get.toNamed('/chatPage');
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(AssetsImage.userImg)),
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
                    '',
                    style: Theme.of(context).textTheme.labelMedium,
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
