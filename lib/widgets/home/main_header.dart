import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/app_icons.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/helper_utils/image_urls.dart';
import 'package:pet_adoption_app/pages/adoption_history_page.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/retry_image.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              style: AppStyle().text.smallLabelBold,
            ),
            Text(
              "John Doe",
              style: AppStyle().text.bodySmallBold,
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () => context.push(const AdoptionHistoryPage()),
          child: AppIcon(
            AppIcons.timeline,
            size: 28,
            color: AppColors().black,
          ),
        ),
      ],
    );
  }
}
