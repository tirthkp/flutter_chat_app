import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/profile_controller.dart';
import 'package:flutter_chat_app/widgets/primary_button.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    RxBool isEdit = false.obs;
    TextEditingController name =
        TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController email =
        TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phone = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController bio =
        TextEditingController(text: profileController.currentUser.value.about);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10,
          bottom: 10,
          top: 25,
        ),
        child: Obx(
          () => ListView(
            reverse: true,
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      radius: 60,
                      child: const Icon(Icons.add_a_photo),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    controller: name,
                    enabled: isEdit.value,
                    decoration: InputDecoration(
                      filled: isEdit.value,
                      border: isEdit.value
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          : InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: bio,
                    enabled: isEdit.value,
                    decoration: InputDecoration(
                      filled: isEdit.value,
                      border: isEdit.value
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          : InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.info,
                      ),
                      labelText: 'About',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: email,
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    textInputAction: TextInputAction.done,
                    controller: phone,
                    enabled: isEdit.value,
                    decoration: InputDecoration(
                      filled: isEdit.value,
                      border: isEdit.value
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          : InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      labelText: 'Mobile No.',
                    ),
                  ),
                  const SizedBox(height: 40),
                  isEdit.value
                      ? PrimaryButton(
                          btnName: 'Save',
                          icon: Icons.save,
                          onTap: () {
                            isEdit.value = false;
                          },
                        )
                      : PrimaryButton(
                          btnName: 'Edit',
                          icon: Icons.edit,
                          onTap: () {
                            isEdit.value = true;
                          },
                        ),
                ],
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }
}
