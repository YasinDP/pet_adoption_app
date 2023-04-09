import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class SuccessTitle extends StatelessWidget {
  const SuccessTitle({
    super.key,
    required this.text,
    required this.style,
    required this.color,
    required this.delay,
  });

  final String text;
  final TextStyle style;
  final Color color;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    Duration t = AppStyle().times.fast;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppStyle().insets.lg),
      child: Animate().custom(
        delay: delay,
        duration: t * 2,
        builder: (_, m, __) => Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: style.copyWith(color: color.withOpacity(m)),
        ),
      ),
    );
  }
}
