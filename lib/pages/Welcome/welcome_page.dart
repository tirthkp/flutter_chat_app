import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/Welcome/widgets/welcome_button.dart';
import 'package:flutter_chat_app/pages/Welcome/widgets/welcome_heading.dart';
import 'package:flutter_chat_app/pages/Welcome/widgets/welcome_body.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WelcomeHeading(),
              Welcomebody(),
              WelcomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
