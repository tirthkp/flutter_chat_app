import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/Welcome/widgets/welcome_heading.dart';
import 'package:flutter_chat_app/pages/auth/widgets/auth_body.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                WelcomeHeading(),
                SizedBox(
                  height: 40,
                ),
                AuthBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
