import 'package:flutter/material.dart';

class NewContactTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  const NewContactTile(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          width: 50,
          height: 50,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(title),
      ),
    );
  }
}
