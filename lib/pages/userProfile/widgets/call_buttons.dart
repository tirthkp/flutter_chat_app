import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final double size;
  final VoidCallback ontap;
  const CallButton({
    super.key,
    required this.icon,
    required this.name,
    required this.size,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurface,
                size: size,
              ),
              const SizedBox(height: 5),
              Text(
                name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
