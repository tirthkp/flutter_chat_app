import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/contact_controller.dart';
import 'package:get/get.dart';

class DefaultHomeScreen extends StatelessWidget {
  const DefaultHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    Future.delayed(
      const Duration(seconds: 2),
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Start Chatting',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                Get.toNamed('/contactPage');
                await contactController.getUserList();
              },
              child: const Text('Contacts'))
        ],
      ),
    );
  }
}
