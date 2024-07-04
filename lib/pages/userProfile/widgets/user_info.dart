import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/userProfile/widgets/call_buttons.dart';

class UserInfo extends StatelessWidget {
  final String profileImage;
  final String name;
  final String email;
  const UserInfo(
      {super.key,
      required this.profileImage,
      required this.name,
      required this.email});

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
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(profileImage),
                ),
                shape: BoxShape.circle,
              ),
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
                  icon: Icons.phone,
                  name: 'Call',
                  size: 30,
                  ontap: () {},
                ),
                CallButton(
                  icon: Icons.videocam,
                  name: 'Video',
                  size: 30,
                  ontap: () {},
                ),
                CallButton(
                  icon: Icons.chat_bubble,
                  name: 'Chat',
                  size: 25,
                  ontap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
