import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_svg/svg.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool inComming;
  final String time;
  final String status;
  final String imageUrl;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.inComming,
      required this.time,
      required this.status,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment:
            inComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: MediaQuery.of(context).size.width / 1.3,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(inComming ? 0 : 15),
                bottomRight: Radius.circular(inComming ? 15 : 0),
              ),
            ),
            child: imageUrl.isEmpty && message.isNotEmpty
                ? Text(message)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      message == ''
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              height: 10,
                            ),
                      message == '' ? const SizedBox.shrink() : Text(message),
                    ],
                  ),
          ),
          const SizedBox(height: 5),
          inComming
              ? Text(
                  time,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        AssetsImage.chatStatusIcon,
                        width: 20,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
