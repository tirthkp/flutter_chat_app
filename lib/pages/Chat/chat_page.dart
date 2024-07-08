import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_chat_app/controller/chat_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/bottom_navbar.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/chat_app_bar.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/chat_bubble.dart';

import 'package:get/get.dart';

import '../../model/user_model.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());

    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: ChatAppBar(userModel: userModel),
      bottomNavigationBar: BottomNavbar(userModel: userModel),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            StreamBuilder(
              stream: chatController.getMessages(userModel.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error:${snapshot.error}"),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                          message: snapshot.data![index].message!,
                          inComming: snapshot.data![index].senderId !=
                              profileController.currentUser.value.id,
                          time: snapshot.data![index].currentTime!,
                          status: '',
                          imageUrl: snapshot.data![index].imageUrl ?? '');
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Start chatting'),
                  );
                }
              },
            ),
            Obx(
              () => (chatController.selectedImagePath.value != '')
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: IntrinsicHeight(
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.sizeOf(context).height / 1.5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  chatController.selectedImagePath.value = '';
                                },
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, bottom: 8),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: double.infinity,
                                      minHeight: 0,
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              1.7),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      File(chatController
                                          .selectedImagePath.value),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
