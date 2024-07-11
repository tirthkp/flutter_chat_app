import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/images.dart';
import 'package:flutter_chat_app/config/strings.dart';
import 'package:flutter_chat_app/config/theme/theme_service.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:flutter_chat_app/controller/group_controller.dart';
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
  GroupController groupController = Get.put(GroupController());
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
                ThemeService().changeThemeMode();
              },
              icon: Icon(
                Get.isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                Get.toNamed('/profilePage');
              },
              icon: const Icon(
                Icons.person_2_outlined,
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
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
        body: TabBarView(
          controller: tabController,
          children: [
            contactController.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : RefreshIndicator(
                    child: homeController.chatRoomList.isNotEmpty
                        ? const ChatList()
                        : const DefaultHomeScreen(),
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      await homeController.getChatRoomList();
                    }),
            groupController.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : RefreshIndicator(
                    child: homeController.chatRoomList.isNotEmpty
                        ? const GroupsPage()
                        : const DefaultHomeScreen(),
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      await groupController.getGroups();
                    }),
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
    );
  }
}
