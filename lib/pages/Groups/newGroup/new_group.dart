import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:flutter_chat_app/pages/Groups/newGroup/group_details.dart';
import 'package:get/get.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          elevation: 0,
          backgroundColor: groupController.groupMembers.isEmpty
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupController.groupMembers.isEmpty) {
              Get.snackbar('Error',
                  'Please select at least one contact to create a group.',
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  colorText: Theme.of(context).colorScheme.onSurface);
            } else {
              Get.to(() => const GroupDetails(),
                  transition: Transition.rightToLeft);
            }
          },
          child: Icon(
            Icons.arrow_forward_ios,
            color: groupController.groupMembers.isEmpty
                ? Theme.of(context).colorScheme.onSurface
                : Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: contactController.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => ListTile(
                      selected: groupController.groupMembers
                          .contains(snapshot.data![index]),
                      selectedColor: Colors.white,
                      selectedTileColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        groupController.selectMember(snapshot.data![index]);
                      },
                      horizontalTitleGap: 15,
                      leading: CachedNetworkImage(
                        imageUrl: snapshot.data![index].profileImage == '' ||
                                snapshot.data![index].profileImage == null
                            ? AssetsImage.userImg
                            : snapshot.data![index].profileImage!,
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        snapshot.data![index].name!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        snapshot.data![index].about == '' ||
                                snapshot.data![index].about == null
                            ? "Hey there, I'm a developer"
                            : snapshot.data![index].about!,
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      tileColor: Theme.of(context).colorScheme.primaryContainer,
                      trailing: groupController.groupMembers
                              .contains(snapshot.data![index])
                          ? const Icon(Icons.done)
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Start chatting...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }
}
