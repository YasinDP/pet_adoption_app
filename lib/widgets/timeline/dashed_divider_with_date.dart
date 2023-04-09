import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/timeline/dashed_line.dart';

class DashedDividerWithCount extends StatelessWidget {
  const DashedDividerWithCount(this.count, {Key? key}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(child: DashedLine()),
        if (count > 0)
          CenterRight(
            child: FractionalTranslation(
              translation: const Offset(0, -.5),
              child: MergeSemantics(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$count Adoptions",
                      style: AppStyle().text.h3.copyWith(
                          color: AppColors().white,
                          shadows: AppStyle().shadows.text),
                    ),
                    Gap(AppStyle().insets.xs),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
