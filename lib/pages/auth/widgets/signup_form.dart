import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/widgets/primary_button.dart';
import 'package:get/get.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    AuthController authController = Get.put(AuthController());

    return Column(
      children: [
        const SizedBox(height: 20),
        TextField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          controller: name,
          decoration: const InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(
              Icons.person,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: email,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.alternate_email_rounded,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => TextField(
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.visiblePassword,
            controller: password,
            obscureText: authController.isVisible.value ? true : false,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(authController.isVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () => authController.isvisible(),
              ),
              hintText: "Password",
              prefixIcon: const Icon(
                Icons.password_outlined,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Obx(
          () => authController.isLoading.value
              ? const CircularProgressIndicator()
              : PrimaryButton(
                  onTap: () {
                    if (name.text != '' &&
                        email.text != '' &&
                        password.text != '') {
                      authController.createUser(
                        name.text,
                        email.text,
                        password.text,
                      );
                    }
                  },
                  btnName: "Signup",
                  icon: Icons.lock_outline_sharp,
                ),
        ),
      ],
    );
  }
}
