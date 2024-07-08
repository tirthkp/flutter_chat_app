import 'package:flutter/material.dart';

class ImagePickerButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const ImagePickerButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, top: 15),
      child: Container(
        constraints: const BoxConstraints(minHeight: 80, minWidth: 80),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            size: 40,
          ),
        ),
      ),
    );
  }
}
