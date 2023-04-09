import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/success_page/animated_ribbon.dart';

class SuccessRibbon extends StatelessWidget {
  const SuccessRibbon({super.key});

  @override
  Widget build(BuildContext context) {
    Duration t = AppStyle().times.fast;
    return AnimatedRibbon("New Pet Adopted".toUpperCase()).animate().scale(
        begin: const Offset(0.3, 0.3),
        duration: t * 2,
        curve: Curves.easeOutExpo,
        alignment: const Alignment(0, -1));
  }
}
