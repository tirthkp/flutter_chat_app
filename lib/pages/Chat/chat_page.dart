import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/chat_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/chat_bubble.dart';
import 'package:flutter_chat_app/pages/userProfile/user_profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController message = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
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
              Get.to(() => UserProfile(userModel: userModel));
            },
            leading:
                userModel.profileImage != null && userModel.profileImage != ''
                    ? Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(userModel.profileImage!),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(AssetsImage.userImg)),
            title: Text(
              userModel.name ?? 'User',
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
        ),
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
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        message: snapshot.data![index].message!,
                        inComming: snapshot.data![index].senderId !=
                            profileController.currentUser.value.id,
                        time: snapshot.data![index].timeStamp!,
                        status: '',
                        imageUrl: snapshot.data![index].imageUrl ?? '');
                  },
                );
              } else {
                return const Center(
                  child: Text('Start chating'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
