import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:flutter_chat_app/pages/userProfile/widgets/call_buttons.dart';

import '../../../config/images.dart';

class UserInfo extends StatelessWidget {
  final String profileImage;
  final String name;
  final String email;
  final UserModel userModel;
  const UserInfo(
      {super.key,
      required this.profileImage,
      required this.name,
      required this.email,
      required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            userModel.profileImage != null && userModel.profileImage != ''
                ? CachedNetworkImage(
                    imageUrl: userModel.profileImage!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 120,
                        width: 120,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: AssetsImage.userImg,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 120,
                        width: 120,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CallButton(
                  icon: Icons.phone_outlined,
                  name: 'Call',
                  size: 30,
                  ontap: () {},
                  color: Colors.green.withOpacity(0.5),
                ),
                CallButton(
                  icon: Icons.videocam_outlined,
                  name: 'Video',
                  size: 30,
                  ontap: () {},
                  color: Colors.blue.withOpacity(0.5),
                ),
                CallButton(
                  icon: Icons.chat_bubble_outline,
                  name: 'Chat',
                  size: 25,
                  ontap: () {},
                  color: Colors.red.withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
