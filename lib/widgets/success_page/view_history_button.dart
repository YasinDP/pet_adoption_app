import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/ui_utils/buttons.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/pages/adoption_history_page.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class ViewAdoptionHistoryButton extends StatelessWidget {
  const ViewAdoptionHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    Duration t = AppStyle().times.med;
    return AppBtn.from(
      text: "view in my collection",
      isSecondary: true,
      onPressed: () => context.pushReplacement(const AdoptionHistoryPage()),
    ).animate().fadeIn(delay: t).move(
          begin: const Offset(0, 50),
          duration: t,
          curve: Curves.easeOutCubic,
        );
  }
}
