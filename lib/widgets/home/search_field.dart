import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/app_icons.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPx,
      padding: [4, 8].edgeInsets,
      decoration: BoxDecoration(
        borderRadius: 12.borderRadius,
        color: AppColors().greyMedium.withOpacity(0.2),
      ),
      child: Row(
        children: [
          AppIcon(
            AppIcons.search,
            color: AppColors().black,
          ),
          8.spacing,
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search",
              ),
              style: AppStyle().text.labelFont,
            ),
          ),
        ],
      ),
    );
  }
}
