import 'package:flutter_chat_app/pages/Home/home_page.dart';
import 'package:flutter_chat_app/pages/contact/contact_page.dart';
import 'package:flutter_chat_app/pages/profilePage/profile_page.dart';

import 'package:get/get.dart';

import '../pages/auth/auth_page.dart';
import '../pages/userProfile/update_user_profile.dart';

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
    name: '/updateUserProfilePage',
    page: () => const UpdateUserProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/profilePage',
    page: () => const ProfilePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/contactPage',
    page: () => const ContactPage(),
    transition: Transition.rightToLeft,
  ),
];
