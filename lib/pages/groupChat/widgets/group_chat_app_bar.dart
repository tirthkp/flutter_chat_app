import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/group_chat_model.dart';
import 'package:flutter_chat_app/pages/groupChat/widgets/group_info.dart';

import 'package:get/get.dart';

import '../../../config/images.dart';

class GroupChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GroupModel groupModel;
  const GroupChatAppBar({super.key, required this.groupModel});

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
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_sharp,
        ),
      ),
      title: ListTile(
        enableFeedback: false,
        splashColor: Colors.transparent,
        onTap: () {
          Get.to(
              GroupInfo(
                groupModel: groupModel,
              ),
              transition: Transition.rightToLeft);
        },
        leading: groupModel.profileImage != null &&
                groupModel.profileImage != ''
            ? CachedNetworkImage(
                imageUrl: groupModel.profileImage!,
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
                imageUrl: AssetsImage.groupImg,
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
          groupModel.name!,
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
