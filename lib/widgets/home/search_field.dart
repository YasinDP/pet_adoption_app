import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/ui_utils/app_icons.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  Timer? _debounce;
  void onChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final provider = ref.read(appProvider);
      provider.updateQuery(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
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
            color: theme.iconColor,
          ),
          8.spacing,
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search",
              ),
              style: AppStyle().text.largeFont.copyWith(
                    color: theme.labelColor,
                  ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
