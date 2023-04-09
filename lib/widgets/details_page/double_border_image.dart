import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_image.dart';

class DoubleBorderImage extends StatelessWidget {
  const DoubleBorderImage(this.primaryImage, {Key? key}) : super(key: key);
  final String primaryImage;
  @override
  Widget build(BuildContext context) => Container(
        // Add an outer border with the rounded ends.
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: AppColors().offWhite, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(999)),
        ),

        child: Padding(
          padding: EdgeInsets.all(AppStyle().insets.xs),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: ColoredBox(
              color: AppColors().greyMedium,
              child: Hero(
                tag: primaryImage,
                child: AppImage(
                    image: NetworkImage(primaryImage),
                    fit: BoxFit.cover,
                    scale: 0.5),
              ),
            ),
          ),
        ),
      );
}
