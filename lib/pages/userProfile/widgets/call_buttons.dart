import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final double size;
  final VoidCallback ontap;
  final Color color;
  const CallButton({
    super.key,
    required this.icon,
    required this.name,
    required this.size,
    required this.ontap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurface,
                size: size,
              ),
              const SizedBox(width: 5),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
