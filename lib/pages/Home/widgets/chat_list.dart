import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            onTap: () {
              Get.toNamed('/chatPage');
            },
            horizontalTitleGap: 15,
            leading: Image.asset(AssetsImage.boyPic),
            title: Text(
              "Tirth Patel",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              'Hello how are you?',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            tileColor: Theme.of(context).colorScheme.primaryContainer,
            trailing: Text(
              '08:00 PM',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}
