import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:flutter_chat_app/model/group_chat_model.dart';
import 'package:flutter_chat_app/pages/Chat/widgets/image_picker_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/images.dart';

class GroupBottomBar extends StatelessWidget {
  final GroupModel groupModel;
  const GroupBottomBar({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    ScrollController scrollController = ScrollController();
    ImageController imageController = Get.put(ImageController());
    GroupController groupController = Get.put(GroupController());
    RxString mess = ''.obs;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.emoji_emotions_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Scrollbar(
                  interactive: true,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: scrollController,
                  child: TextField(
                    onChanged: (value) {
                      mess.value = value;
                    },
                    scrollController: scrollController,
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintText: "Type your message...",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: InkWell(
                    onTap: () async {
                      Get.bottomSheet(
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ImagePickerButton(
                                onTap: () async {
                                  groupController.selectedImagePath.value =
                                      await imageController
                                          .pickImage(ImageSource.camera);
                                  Get.back();
                                },
                                icon: Icons.photo_camera_outlined,
                              ),
                              ImagePickerButton(
                                onTap: () async {
                                  groupController.selectedImagePath.value =
                                      await imageController
                                          .pickImage(ImageSource.gallery);
                                  Get.back();
                                },
                                icon: Icons.photo_outlined,
                              ),
                              ImagePickerButton(
                                onTap: () {},
                                icon: Icons.play_arrow_outlined,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      AssetsImage.galleryIcon,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Obx(
                  () {
                    return mess.value == '' &&
                            groupController.selectedImagePath.value == ''
                        ? groupController.isLoading.value
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                height: 30,
                                width: 30,
                                child: SvgPicture.asset(
                                  AssetsImage.micIcon,
                                  height: 30,
                                  width: 30,
                                ),
                              )
                        : InkWell(
                            onTap: () async {
                              String msg = message.text.trim();
                              if (msg != '' ||
                                  groupController.selectedImagePath.value !=
                                      '') {
                                groupController.sendGroupMessage(
                                  message.text,
                                  groupModel.id!,
                                  groupController.selectedImagePath.value,
                                );

                                message.clear();
                                mess.value = '';
                                msg = '';
                              } else {
                                message.clear();
                                mess.value = '';
                              }
                            },
                            child: groupController.isLoading.value
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: SvgPicture.asset(
                                      AssetsImage.sendIcon,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
