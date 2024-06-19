// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/images.dart';
import '../../../config/strings.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SvgPicture.asset(
            AssetsImage.appIcon,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          AppStrings.appName,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
