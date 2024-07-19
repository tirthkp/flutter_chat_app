import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/pages/Groups/newGroup/new_group.dart';
import 'package:flutter_chat_app/pages/contact/widgets/contact_list.dart';
import 'package:flutter_chat_app/pages/contact/widgets/new_contact_tile.dart';
import 'package:flutter_chat_app/widgets/chat_tile.dart';
import 'package:get/get.dart';

import '../../config/images.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearch = false.obs;
    ContactController contactController = Get.put(ContactController());
    TextEditingController text = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Obx(
          () => isSearch.value
              ? TextField(
                  onChanged: (value) {
                    contactController.search.value = text.text;
                  },
                  controller: text,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search contacts',
                    hintStyle: Theme.of(context).textTheme.labelLarge,
                    border: InputBorder.none,
                    filled: false,
                  ),
                )
              : const Text('Contacts'),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearch.toggle();
              },
              icon: Icon(isSearch.value ? Icons.close : Icons.search),
            ),
          ),
        ],
      ),
      body: Obx(
        () => contactController.search.value != ''
            ? StreamBuilder(
                stream: contactController.getContactList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(contactController.search.value);
                        return ChatTile(
                            title: snapshot.data![index].name!,
                            imageUrl: snapshot.data![index].profileImage ??
                                AssetsImage.userImg,
                            subTitle:
                                snapshot.data![index].about ?? "Hey There",
                            time: '',
                            ontap: () {});
                      },
                    );
                  } else {
                    return const Center(child: Text('No person found'));
                  }
                },
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    NewContactTile(
                      icon: Icons.person_add_alt_1,
                      title: 'New Contact',
                      onTap: () {},
                    ),
                    NewContactTile(
                      icon: Icons.group_add,
                      title: 'New Group',
                      onTap: () {
                        Get.to(() => const NewGroup(),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Contacts',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 15),
                    contactController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : const ContactList(),
                  ],
                ),
              ),
      ),
    );
  }
}
