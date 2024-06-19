import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../config/images.dart';
import '../../../config/strings.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Get.offAllNamed('/authPage');
        return null;
      },
      innerColor: Theme.of(context).colorScheme.primary,
      outerColor: Theme.of(context).colorScheme.primaryContainer,
      sliderButtonIcon: SvgPicture.asset(
        AssetsImage.plugIcon,
        width: 25,
      ),
      submittedIcon: SvgPicture.asset(AssetsImage.connectIcon),
      text: WelcomePageString.slideToStart,
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }
}
