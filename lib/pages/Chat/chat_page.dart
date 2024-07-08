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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: ChatAppBar(userModel: userModel),
        bottomNavigationBar: BottomNavbar(userModel: userModel),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: chatController.getMessages(userModel.id!),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error:${snapshot.error}"),
                );
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
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
        ),
      ),
    );
  }
}
