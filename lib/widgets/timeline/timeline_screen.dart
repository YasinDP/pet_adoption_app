import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_header.dart';
import 'package:pet_adoption_app/widgets/timeline/scrolling_viewport.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  /// Create a scroll controller that the top and bottom timelines can share
  final ScrollController _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      const double minSize = 1200;
      const double maxSize = 5500;
      return Container(
        color: AppColors().black,
        child: Column(
          children: [
            const AppHeader(title: "Adoption History"),

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
