import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/timeline/dashed_line.dart';

class DashedDividerWithCount extends ConsumerWidget {
  const DashedDividerWithCount(this.count, {Key? key}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final bool isDark = theme.isDark;
    String countText = count == 1 ? "1 Adoption" : "$count Adoptions";
    return Stack(
      children: [
        Center(
            child: DashedLine(
          color: theme.iconColor,
        )),
        if (count > 0)
          CenterRight(
            child: FractionalTranslation(
              translation: const Offset(0, -.5),
              child: MergeSemantics(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      countText,
                      style: AppStyle().text.h3.copyWith(
                          color: theme.fgColor,
                          shadows: isDark
                              ? AppStyle().shadows.whiteText
                              : AppStyle().shadows.text),
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
