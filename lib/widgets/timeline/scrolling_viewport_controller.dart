import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/helper_utils/functions.dart';
import 'package:pet_adoption_app/models.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/timeline/scrolling_viewport.dart';

class ScrollingViewportController extends ChangeNotifier {
  ScrollingViewportController(this.state);
  final NewScalingViewportState state;

  DateTime get startYr => lastYear();
  DateTime get endYr => currentMonth();

  late final List<DateTime> _totalMonths = getMonthsBetween(
    startDate: startYr,
    endDate: endYr,
  );

  int get startMonthPosition => 0;
  int get endMonthPosition => _totalMonths.length - 1;

  late BoxConstraints constraints;
  NewScrollingViewport get widget => state.widget;
  ScrollController get scroller => widget.scroller;

  void init() {
    scheduleMicrotask(() async {
      await Future.delayed(500.milliseconds);
      final pos = calculateScrollPosFromMonth(endMonthPosition);
      scroller.jumpTo(pos - 200);
      scroller.animateTo(pos,
          duration: 1.35.seconds, curve: Curves.easeOutCubic);
    });
  }

  /// Jump to the scroll position for a given month. Does not animated.
  void jumpToMonth(int month, {bool animate = false}) {
    double monthRatio =
        (month - startMonthPosition) / (endMonthPosition - startMonthPosition);
    double newMaxScroll = calculateContentHeight();
    final newPos = newMaxScroll * monthRatio;
    if (animate) {
      scroller.animateTo(newPos,
          duration: AppStyle().times.med, curve: Curves.easeOut);
    } else {
      scroller.jumpTo(newPos);
    }
  }

  /// Calculates current content height, taking zoom into account.
  double calculateContentHeight() {
    final gap = AppStyle().insets.xs;
    return (TimelineEvent.all.length * (100 + gap)) - (50);
  }

  /// Derive current month based on the scroll position and the current content height.
  int calculateMonthPositionFromScrollPos() {
    if (scroller.hasClients == false) return startMonthPosition;
    int totalYrs = endMonthPosition - startMonthPosition;
    double currentPx = scroller.position.pixels;
    double scrollAmt = currentPx / calculateContentHeight();
    int result = (startMonthPosition + scrollAmt * totalYrs).round();
    return result.clamp(startMonthPosition, endMonthPosition);
  }

  double calculateScrollPosFromMonth(int month) {
    int totalMonths = endMonthPosition - startMonthPosition;
    double monthFraction = totalMonths / (month - startMonthPosition);
    return calculateContentHeight() / monthFraction;
  }
}
