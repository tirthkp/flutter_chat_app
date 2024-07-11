import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/images.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ImageController imageController = Get.put(ImageController());
    RxString imagePath = ''.obs;
    TextEditingController groupName = TextEditingController();
    RxString text = ''.obs;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('New Group'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          elevation: 0,
          backgroundColor: text.value == ''
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            text.value = groupName.text.trim();
            if (text.value != '') {
              groupController.createGroup(groupName.text, imagePath.value);
              Get.snackbar(
                'Group Created',
                'Group Created Successfully',
                backgroundColor: Theme.of(context).colorScheme.surface,
                colorText: Theme.of(context).colorScheme.onSurface,
              );
              Get.offAllNamed('/homePage');
            } else {
              Get.snackbar("Error", "Please enter group name",
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  colorText: Theme.of(context).colorScheme.onSurface);
              groupName.clear();
            }
          },
          child: groupController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(
                  Icons.done,
                  color: text.value == ''
                      ? Theme.of(context).colorScheme.onSurface
                      : Colors.white,
                ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Obx(
                        () => Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            image: DecorationImage(
                              image: imagePath.value == ''
                                  ? const CachedNetworkImageProvider(
                                      AssetsImage.groupImg)
                                  : FileImage(
                                      File(imagePath.value),
                                    ) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () async {
                                  imagePath.value =
                                      await imageController.pickImage(
                                    ImageSource.gallery,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        text.value = groupName.text.trim();
                      },
                      controller: groupName,
                      decoration: const InputDecoration(
                        hintText: 'Group Name',
                        prefixIcon: Icon(
                          Icons.group,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: groupController.groupMembers
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          horizontalTitleGap: 15,
                          leading: CachedNetworkImage(
                            imageUrl:
                                e.profileImage == '' || e.profileImage == null
                                    ? AssetsImage.userImg
                                    : e.profileImage!,
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
                            e.name!,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            e.about == '' || e.about == null
                                ? "hey there"
                                : e.about!,
                            style: Theme.of(context).textTheme.labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          tileColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                    .toList()),
          )
        ],
      ),
    );
  }
}
