import 'dart:math';

import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';

import 'package:pet_adoption_app/implementations/adoption_impl.dart';
import 'package:pet_adoption_app/models.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/success_page/centered_box.dart';
import 'package:pet_adoption_app/widgets/timeline/dashed_divider_with_date.dart';
import 'package:pet_adoption_app/widgets/timeline/scrolling_viewport_controller.dart';
import 'package:pet_adoption_app/widgets/timeline/timeline_section.dart';
import 'package:pet_adoption_app/widgets/timeline/list_gradient.dart';

class NewScrollingViewport extends ConsumerStatefulWidget {
  const NewScrollingViewport({
    Key? key,
    required this.scroller,
    required this.minSize,
    required this.maxSize,
  }) : super(key: key);
  final double minSize;
  final double maxSize;
  final ScrollController scroller;

  @override
  ConsumerState<NewScrollingViewport> createState() =>
      NewScalingViewportState();
}

class NewScalingViewportState extends ConsumerState<NewScrollingViewport> {
  late final ScrollingViewportController controller =
      ScrollingViewportController(this);

  List<Adoption> adoptions = AdoptionImplementation.userAdoptions;

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int getAdoptionCountFromMonth() {
    int month = controller.calculateMonthPositionFromScrollPos();
    DateTime timelineDate = TimelineEvent.all[month].month;
    return AdoptionImplementation.getAdoptionCountFromMonth(timelineDate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content area
        _buildScrollingArea(context).animate().fadeIn(),

        // Dashed line with a year that changes as we scroll
        IgnorePointer(
          ignoringSemantics: false,
          child: AnimatedBuilder(
            animation: controller.scroller,
            builder: (_, __) {
              return DashedDividerWithCount(getAdoptionCountFromMonth());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScrollingArea(BuildContext context) {
    final provider = ref.watch(appProvider);
    List<TimelineEvent> timelineData = TimelineEvent.all;
    final gap = AppStyle().insets.xs;

    return LayoutBuilder(
      builder: (_, constraints) {
        // cache constraints, so they can be used to maintain the selected year while zooming
        controller.constraints = constraints;
        double vtPadding = constraints.maxHeight / 2;
        // double height = controller.calculateContentHeight();
        double height = (timelineData.length * (100 + gap)) - gap;
        final width =
            min(AppStyle().sizes.maxContentWidth2, constraints.maxWidth);
        return Stack(
          children: [
            SingleChildScrollView(
              controller: controller.scroller,
              padding: EdgeInsets.symmetric(vertical: vtPadding),
              // A stack inside a SizedBox which sets its overall height
              child: CenteredBox(
                height: height,
                width: width,
                child: Column(
                  children: timelineData.asMap().entries.map((e) {
                    List<Pet> adoptedPets = provider.getAdoptedPetsInMonth(
                      e.value.month,
                    );
                    return Container(
                      height: 100,
                      padding: EdgeInsets.only(left: gap),
                      margin: e.key == timelineData.length - 1
                          ? null
                          : EdgeInsets.only(bottom: gap),
                      child: Row(
                        children: [
                          Text(
                            e.value.month.monthAndYear,
                            style: AppStyle().text.body.copyWith(
                                  color: Colors.white,
                                  height: 1,
                                ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ListView.builder(
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: adoptedPets.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                height: 100,
                                width: 80,
                                margin: EdgeInsets.only(right: gap),
                                child: TimelineSection(
                                  adoptedPets[index],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            /// Top and bottom gradients for visual style
            const ListOverscollGradient(),
            const BottomCenter(
              child: ListOverscollGradient(bottomUp: true),
            ),
          ],
        );
      },
    );
  }
}
