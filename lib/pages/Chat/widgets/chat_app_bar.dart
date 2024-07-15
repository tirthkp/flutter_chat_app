import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/call_controller.dart';
import 'package:flutter_chat_app/controller/chat_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:get/get.dart';

import '../../../config/images.dart';
import '../../userProfile/user_profile.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserModel userModel;
  const ChatAppBar({super.key, required this.userModel});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    CallController callController = Get.put(CallController());
    ProfileController profileController = Get.put(ProfileController());
    return AppBar(
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(5), child: SizedBox.shrink()),
      scrolledUnderElevation: 0,
      elevation: 0,
      titleSpacing: -10,
      leading: IconButton(
        onPressed: () {
          Get.offAllNamed('/homePage');
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_sharp,
        ),
      ),
      title: ListTile(
        splashColor: Colors.transparent,
        onTap: () {
          Get.to(() => UserProfile(userModel: userModel),
              transition: Transition.rightToLeft);
        },
        leading: userModel.profileImage != null && userModel.profileImage != ''
            ? CachedNetworkImage(
                imageUrl: userModel.profileImage!,
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: AssetsImage.userImg,
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
        title: Text(
          userModel.name ?? 'User',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: StreamBuilder(
            stream: chatController.getStatus(userModel.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('');
              } else {
                return Text(
                  snapshot.data!.status ?? "",
                  style: Theme.of(context).textTheme.labelMedium,
                );
              }
            }),
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
          onPressed: () {
            callController.callAction(
              userModel,
              profileController.currentUser.value,
            );
          },
          icon: const Icon(
            Icons.phone_outlined,
          ),
        ),
      ],
    );
  }
}
