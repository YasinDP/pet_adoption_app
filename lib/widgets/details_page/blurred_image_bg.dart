import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/universal_platforms/platforms.dart';
import 'package:pet_adoption_app/widgets/common/app_image.dart';

/// Blurry image background for the Pets Highlights view. Contains horizontal and vertical gradients that stack overtop the blended image.
class BlurredImageBg extends StatelessWidget {
  const BlurredImageBg({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    final bool useBlurs = !UniversalPlatform.isAndroid;
    final img = AppImage(
      image: url == null ? null : NetworkImage(url!),
      syncDuration: AppStyle().times.fast,
      fit: BoxFit.cover,
      scale: 0.5,
    );
    final fgOpacity = useBlurs ? 0.6 : 0.8;
    return Transform.scale(
      scale: 1.25,
      alignment: const Alignment(0, 0.8),
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: AppColors().black.withOpacity(fgOpacity),
        ),
        child: useBlurs
            ? ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: img,
              )
            : img,
      ),
    );
  }
}
