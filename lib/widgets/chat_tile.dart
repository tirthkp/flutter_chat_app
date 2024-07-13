import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String subTitle;
  final String time;
  final VoidCallback ontap;
  const ChatTile(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.subTitle,
      required this.time,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: ListTile(
        onTap: ontap,
        horizontalTitleGap: 15,
        leading: CachedNetworkImage(
          imageUrl: imageUrl,
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
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.labelLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        trailing: Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
