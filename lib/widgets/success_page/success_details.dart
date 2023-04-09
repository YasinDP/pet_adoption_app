import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_header.dart';
import 'package:pet_adoption_app/widgets/common/pop_navigator_underlay.dart';
import 'package:pet_adoption_app/widgets/success_page/app_backdrop.dart';
import 'package:pet_adoption_app/widgets/success_page/celebration_particles.dart';
import 'package:pet_adoption_app/widgets/success_page/centered_box.dart';
import 'package:pet_adoption_app/widgets/success_page/success_image.dart';
import 'package:pet_adoption_app/widgets/success_page/success_ribbon.dart';
import 'package:pet_adoption_app/widgets/success_page/success_title.dart';
import 'package:pet_adoption_app/widgets/success_page/view_history_button.dart';

class SuccessDetails extends StatelessWidget {
  const SuccessDetails({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    Duration t = AppStyle().times.fast;
    return Stack(key: const ValueKey('detail'), children: [
      /// Background
      AppBackdrop(
        strength: .5,
        child: Container(color: AppColors().greyStrong.withOpacity(.96)),
      ).animate().fadeIn(),

      /// Particles
      CelebrationParticles(fadeMs: (t * 6).inMilliseconds),

      /// invisible close btn
      const PopNavigatorUnderlay(),

      /// Content
      SafeArea(
        child: CenteredBox(
          width: AppStyle().sizes.maxContentWidth3,
          child: Column(
            children: [
              Gap(AppStyle().insets.lg),
              const Spacer(),
              SizedBox(
                height: context.heightPx * .35,
                child: Center(
                  child: SuccessImage(
                    image: pet.primaryImage,
                  ),
                ),
              ),
              Gap(AppStyle().insets.lg),
              const SuccessRibbon(),
              Gap(AppStyle().insets.sm),
              SuccessTitle(
                text: pet.name,
                style: AppStyle().text.h2,
                color: AppColors().offWhite,
                delay: t * 1.5,
              ),
              Gap(AppStyle().insets.xs),
              SuccessTitle(
                text: pet.subtitle.toUpperCase(),
                style: AppStyle().text.title2,
                color: AppColors().accent1,
                delay: t * 2,
              ),
              const Spacer(),
              Gap(AppStyle().insets.lg),
              const ViewAdoptionHistoryButton(),
              Gap(AppStyle().insets.lg),
              const Spacer(),
            ],
          ),
        ),
      ),
      const AppHeader(isTransparent: true)
          .animate()
          .fade(delay: t * 4, duration: t * 2),
    ]);
  }
}
