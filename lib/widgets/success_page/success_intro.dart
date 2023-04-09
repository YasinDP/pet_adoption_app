import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/success_page/success_gradient.dart';

class SuccessIntro extends StatelessWidget {
  const SuccessIntro({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    Duration t = AppStyle().times.fast;
    return Stack(children: [
      Animate().custom(
        duration: t * 5,
        builder: (context, ratio, _) => SuccessGradient(
          ratioIn: ratio,
          ratioOut: 0,
        ),
      ),

      // icon is handled by Hero initially, then scales slowly:
      Center(
        child: FractionallySizedBox(
          widthFactor: 0.33,
          heightFactor: 0.33,
          child: Hero(
            tag: 'collectible_icon_${pet.primaryImage}',
            child: Image(
              image: pet.icon,
              fit: BoxFit.contain,
            ),
          ),
        )
            .animate()
            .scale(
                begin: const Offset(1.5, 1.5),
                end: const Offset(3, 3),
                curve: Curves.easeInExpo,
                delay: t,
                duration: t * 3)
            .fadeOut(),
      )
    ]);
  }
}
