import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/ui_utils/app_icons.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/helper_utils/image_urls.dart';
import 'package:pet_adoption_app/pages/adoption_history_page.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/retry_image.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    bool isDarkTheme = theme.isDark;
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: RetryImage(
            NetworkImage(
              kProfileImageUrl,
            ),
          ),
        ),
        8.spacing,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good morning,",
              style: AppStyle().text.smallBold.copyWith(
                    color: theme.labelColor,
                  ),
            ),
            Text(
              "John Doe",
              style: AppStyle().text.bodySmallBold,
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () => theme.toggleTheme(!isDarkTheme),
          child: Icon(
            isDarkTheme ? Icons.dark_mode_rounded : Icons.dark_mode_outlined,
            size: 28,
            color: theme.iconColor,
          ),
        ),
        12.horizontalSpacing,
        InkWell(
          onTap: () => context.push(const AdoptionHistoryPage()),
          child: AppIcon(
            AppIcons.timeline,
            size: 28,
            color: theme.iconColor,
          ),
        ),
      ],
    );
  }
}
