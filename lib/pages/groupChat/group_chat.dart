import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/model/group_chat_model.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/chat_bubble.dart';

import 'package:get/get.dart';

import 'widgets/group_bottom_bar.dart';
import 'widgets/group_chat_app_bar.dart';

class GroupChat extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChat({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ProfileController profileController = Get.put(ProfileController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: GroupChatAppBar(
          groupModel: groupModel,
        ),
        bottomNavigationBar: GroupBottomBar(
          groupModel: groupModel,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              StreamBuilder(
                stream: groupController.getGroupMessages(groupModel.id!),
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
                    return Center(
                      child: Text(
                        'Start chatting...',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                },
              ),
              Obx(
                () => (groupController.selectedImagePath.value != '')
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    groupController.selectedImagePath.value =
                                        '';
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
                                        File(groupController
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
      ),
    );
  }
}
