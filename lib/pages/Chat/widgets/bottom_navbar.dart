import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/images.dart';
import '../../../controller/chat_controller.dart';
import '../../../model/user_model.dart';

class BottomNavbar extends StatelessWidget {
  final UserModel userModel;
  const BottomNavbar({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    ChatController chatController = Get.put(ChatController());

    return Padding(
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
              Expanded(
                child: TextField(
                  controller: message,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
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
                child: InkWell(
                  onTap: () {
                    String msg = message.text.trim();
                    if (msg.isNotEmpty) {
                      chatController.sendMessage(
                        userModel.id!,
                        message.text,
                        userModel,
                      );
                      message.clear();
                    } else {
                      message.clear();
                    }
                  },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
