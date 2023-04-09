import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';

class SuccessGradient extends StatelessWidget {
  const SuccessGradient({
    super.key,
    required this.ratioIn,
    required this.ratioOut,
  });

  final double ratioIn;
  final double ratioOut;

  @override
  Widget build(BuildContext context) {
    // used by both intro and detail animations to ensure they share a mid-point.
    double ratioInit = Curves.easeOutExpo.transform(ratioIn);
    final double opacity = 1.0 * (ratioInit * 0.8 + ratioOut * 0.2);
    final Color light = AppColors().offWhite;
    final Color dark = AppColors().black;

    // final state is a solid fill, so optimize that case:
    if (ratioOut == 1) return Container(color: dark.withOpacity(opacity));

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color.lerp(light, dark, ratioOut)!.withOpacity(opacity),
            dark.withOpacity(opacity)
          ],
          stops: [0.2, min(1, 0.25 + ratioInit * 0.5 + ratioOut * 0.5)],
        ),
      ),
    );
  }
}
