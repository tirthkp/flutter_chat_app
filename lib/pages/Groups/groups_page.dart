import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {},
          horizontalTitleGap: 15,
          leading: CachedNetworkImage(
            imageUrl: '',
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
            'User',
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
          subtitle: Text(
            "Hey there",
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          trailing: Text('you', style: Theme.of(context).textTheme.bodyMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
