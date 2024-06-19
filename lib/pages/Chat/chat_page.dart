import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          titleSpacing: -10,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
            ),
          ),
          title: ListTile(
            onTap: () {
              Get.toNamed('/profilePage');
            },
            leading: Image.asset(AssetsImage.boyPic),
            title: Text(
              "Tirth Patel",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              'Online',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.videocam_outlined,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.phone_outlined,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        AssetsImage.micIcon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 30,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: false,
                        hintText: "Type your message...",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        AssetsImage.galleryIcon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        AssetsImage.sendIcon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            reverse: true,
            children: const [
              ChatBubble(
                message: 'Hello',
                inComming: true,
                time: '8:00 AM',
                status: 'Seen',
                imageUrl: "",
              ),
              ChatBubble(
                message: 'Hello',
                inComming: false,
                time: '8:00 AM',
                status: 'Seen',
                imageUrl: "",
              ),
              ChatBubble(
                message: 'Hello',
                inComming: false,
                time: '8:00 AM',
                status: 'Seen',
                imageUrl: "",
              ),
              ChatBubble(
                message: 'Hello',
                inComming: false,
                time: '8:00 AM',
                status: 'Seen',
                imageUrl: "https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg",
              ),
              ChatBubble(
                message: 'Hello',
                inComming: true,
                time: '8:00 AM',
                status: 'Seen',
                imageUrl: "https://th.bing.com/th/id/OIG4.LgUj9FIjzUbdTSMn0mRg",
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }
}
