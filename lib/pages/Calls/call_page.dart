import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/call_controller.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/widgets/chat_tile.dart';
import 'package:get/get.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    CallController callController = Get.put(CallController());
    ProfileController profileController = Get.put(ProfileController());
    return StreamBuilder(
      stream: callController.getCalls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ChatTile(
                imageUrl:
                    snapshot.data![index].receiverPic ?? AssetsImage.userImg,
                title: snapshot.data![index].receiverName!,
                ontap: () {},
                subTitle: snapshot.data![index].time!,
                time: snapshot.data![index].callerId ==
                        profileController.currentUser.value.id
                    ? 'sent'
                    : "received",
              );
            },
          );
        } else {
          return const Center(
            child: Text('No Call history available'),
          );
        }
      },
    );
  }
}
