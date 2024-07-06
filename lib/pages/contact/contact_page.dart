import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/home_controller.dart';
import 'package:flutter_chat_app/pages/contact/widgets/contact_list.dart';
import 'package:flutter_chat_app/pages/contact/widgets/new_contact_tile.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearch = false.obs;
    ContactController contactController = Get.put(ContactController());

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () async {
              HomeController homeController = Get.put(HomeController());
              Get.back();
              await homeController.getChatRoomList();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Select Contacts'),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearch.value = !isSearch.value;
              },
              icon: Icon(isSearch.value ? Icons.close : Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Obx(() => isSearch.value
                ? const TextField(
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search contacts',
                      prefixIcon: Icon(Icons.search),
                    ),
                  )
                : const SizedBox.shrink()),
            NewContactTile(
              icon: Icons.person_add_alt_1,
              title: 'New Contact',
              onTap: () {},
            ),
            NewContactTile(
              icon: Icons.group_add,
              title: 'New Group',
              onTap: () {},
            ),
            const SizedBox(height: 15),
            Text(
              'Contacts',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            Obx(
              () => contactController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const ContactList(),
            ),
          ],
        ),
      ),
    );
  }
}
