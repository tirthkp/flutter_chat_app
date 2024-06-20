import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/widgets/primary_button.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    AuthController authController = Get.put(AuthController());

    return Column(
      children: [
        const SizedBox(height: 30),
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
                onPressed: () => authController.isVisible.toggle(),
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
                    authController.login(
                      email.text,
                      password.text,
                    );
                  },
                  btnName: "LOGIN",
                  icon: Icons.lock_open_sharp,
                ),
        ),
      ],
    );
  }
}
