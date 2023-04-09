import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/ui_utils/app_icons.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/circle_buttons.dart';

class AppHeader extends ConsumerWidget {
  const AppHeader({
    Key? key,
    this.title,
    this.subtitle,
    this.showBackBtn = true,
    this.isTransparent = false,
    this.onBack,
    this.trailing,
    this.backIcon = AppIcons.prev,
    this.backBtnSemantics,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final bool showBackBtn;
  final AppIcons backIcon;
  final String? backBtnSemantics;
  final bool isTransparent;
  final VoidCallback? onBack;
  final Widget Function(BuildContext context)? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider).isDark;
    return ColoredBox(
      color: isTransparent
          ? Colors.transparent
          : isDark
              ? AppColors().black
              : AppColors().accent1,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64 * AppStyle().scale,
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Row(children: [
                    Gap(AppStyle().insets.sm),
                    if (showBackBtn)
                      BackBtn(
                        onPressed: onBack,
                        icon: backIcon,
                        semanticLabel: backBtnSemantics,
                      ),
                    const Spacer(),
                    if (trailing != null) trailing!.call(context),
                    Gap(AppStyle().insets.sm),
                    //if (showBackBtn) Container(width: AppStyle().insets.lg * 2, alignment: Alignment.centerLeft, child: child),
                  ]),
                ),
              ),
              MergeSemantics(
                child: Semantics(
                  header: true,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!.toUpperCase(),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            style: AppStyle().text.h4.copyWith(
                                // color: AppColors().offWhite,
                                fontWeight: FontWeight.w500),
                          ),
                        if (subtitle != null)
                          Text(
                            subtitle!.toUpperCase(),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            style: AppStyle()
                                .text
                                .title1
                                .copyWith(color: AppColors().accent1),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
