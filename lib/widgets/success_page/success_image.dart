import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_image.dart';

class SuccessImage extends StatelessWidget {
  const SuccessImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    Duration t = AppStyle().times.fast;
    // build an image with animated shadows and scaling
    return Hero(
      tag: 'collectible_image_$image',
      child: AppImage(image: NetworkImage(image), scale: 1.0)
          .animate()
          .custom(
            duration: t * 6,
            builder: (_, ratio, child) => Container(
              padding: EdgeInsets.all(AppStyle().insets.xxs),
              margin: EdgeInsets.symmetric(horizontal: AppStyle().insets.xl),
              decoration:
                  BoxDecoration(color: AppColors().offWhite, boxShadow: [
                BoxShadow(
                  color: AppColors().accent1.withOpacity(ratio * 0.75),
                  blurRadius: AppStyle().insets.xl * 2,
                ),
                BoxShadow(
                  color: AppColors().black.withOpacity(ratio * 0.75),
                  offset: Offset(0, AppStyle().insets.xxs),
                  blurRadius: AppStyle().insets.sm,
                ),
              ]),
              child: child,
            ),
          )
          .scale(
              begin: const Offset(0.3, 0.3),
              duration: t * 2,
              curve: Curves.easeOutExpo,
              alignment: const Alignment(0, 0.7)),
    );
  }
}
