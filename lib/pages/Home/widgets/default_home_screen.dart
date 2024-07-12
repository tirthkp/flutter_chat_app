import 'package:flutter/material.dart';

class DefaultHomeScreen extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String buttonText;
  const DefaultHomeScreen(
      {super.key,
      required this.text,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            onPressed: onTap,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
