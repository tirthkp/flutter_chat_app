import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
            : Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(AssetsImage.userImg),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
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
    );
  }
}
