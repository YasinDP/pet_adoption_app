import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/universal_platforms/platforms.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    Key? key,
    this.strength = 1,
    this.child,
  }) : super(key: key);

  final double strength;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool useBlurs = !UniversalPlatform.isAndroid;
    final double normalStrength = clampDouble(strength, 0, 1);
    if (useBlurs) {
      return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: normalStrength * 15, sigmaY: normalStrength * 15),
        child: child ?? const SizedBox.expand(),
      );
    }
    final fill = Container(color: AppColors().black.withOpacity(.8 * strength));
    return child == null
        ? fill
        : Stack(
            children: [
              child!,
              Positioned.fill(child: fill),
            ],
          );
  }
}
