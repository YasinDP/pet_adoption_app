import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_header.dart';
import 'package:pet_adoption_app/widgets/timeline/scrolling_viewport.dart';

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends ConsumerState<TimelineScreen> {
  /// Create a scroll controller that the top and bottom timelines can share
  final ScrollController _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(appProvider);
    final theme = ref.watch(themeProvider);
    return LayoutBuilder(builder: (_, constraints) {
      const double minSize = 1200;
      const double maxSize = 5500;
      return Container(
        color: theme.bgColor,
        child: Column(
          children: [
            AppHeader(
              title: "Adoption History",
              // isTransparent: !theme.isDark,
              trailing: (context) => InkWell(
                onTap: () => provider.clearData(),
                child: Icon(
                  Icons.restore,
                  color: theme.iconColor,
                ),
              ),
            ),

            /// Vertically scrolling timeline, manages a ScrollController.
            Expanded(
              child: NewScrollingViewport(
                scroller: _scroller,
                minSize: minSize,
                maxSize: maxSize,
              ),
            ),
            Gap(AppStyle().insets.xs),
          ],
        ),
      );
    });
  }
}
