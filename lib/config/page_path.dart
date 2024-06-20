import 'package:flutter_chat_app/pages/Chat/chat_page.dart';
import 'package:flutter_chat_app/pages/Home/home_page.dart';
import 'package:flutter_chat_app/pages/profilePage/profile_page.dart';
import 'package:flutter_chat_app/pages/userProfile/user_profile.dart';
import 'package:flutter_chat_app/pages/userProfile/update_user_profile.dart';
import 'package:get/get.dart';

import '../pages/auth/auth_page.dart';

var pagePath = [
  GetPage(
    name: '/authPage',
    page: () => const AuthPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/homePage',
    page: () => const HomePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/chatPage',
    page: () => const ChatPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/userProfilePage',
    page: () => const UserProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/updateUserProfilePage',
    page: () => const UpdateUserProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/profilePage',
    page: () => const ProfilePage(),
    transition: Transition.rightToLeft,
  ),
];
