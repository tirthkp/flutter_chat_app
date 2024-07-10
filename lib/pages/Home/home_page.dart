import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/config/strings.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/home_controller.dart';
import 'package:flutter_chat_app/controller/image_controller.dart';
import 'package:flutter_chat_app/pages/Groups/groups_page.dart';
import 'package:flutter_chat_app/pages/Home/widgets/chat_list.dart';
import 'package:flutter_chat_app/pages/Home/widgets/default_home_screen.dart';
import 'package:flutter_chat_app/pages/Home/widgets/tab_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final auth = FirebaseAuth.instance;
  ProfileController profileController = Get.put(ProfileController());
  ImageController imageController = Get.put(ImageController());
  AuthController authController = Get.put(AuthController());
  ContactController contactController = Get.put(ContactController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AssetsImage.appIcon,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
              icon: Icon(
                Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                Get.toNamed('/profilePage');
              },
              icon: const Icon(
                Icons.person,
                size: 30,
              ),
            ),
          ],
          bottom: myTabBar(tabController, context),
        ),
        floatingActionButton: homeController.chatRoomList.isEmpty
            ? null
            : FloatingActionButton(
                elevation: 0,
                onPressed: () async {
                  Get.toNamed('/contactPage');
                  await contactController.getUserList();
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBarView(
            controller: tabController,
            children: [
              contactController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      child: homeController.chatRoomList.isNotEmpty
                          ? const ChatList()
                          : const DefaultHomeScreen(),
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        await homeController.getChatRoomList();
                      }),
              const GroupsPage(),
              ListView(
                children: const [
                  ListTile(
                    title: Text('Calls'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
