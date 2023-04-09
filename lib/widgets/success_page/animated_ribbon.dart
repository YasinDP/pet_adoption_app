import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/helper_utils/assets.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class AnimatedRibbon extends StatelessWidget {
  const AnimatedRibbon(this.text, {Key? key}) : super(key: key);

  final String text;
  static const double height = 48;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEnd(context, false),
            const Spacer(),
            _buildEnd(context, true),
          ],
        ),
      ),
      Container(
        height: height,
        color: AppColors().accent1,
        padding: EdgeInsets.symmetric(horizontal: AppStyle().insets.sm),
        margin: const EdgeInsets.only(bottom: 10),
        // this aligns the text vertically, without expanding the container:
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                textAlign: TextAlign.center, style: AppStyle().text.title1)
          ],
        ),
      ),
    ]);
  }

  Widget _buildEnd(BuildContext context, bool flip) {
    Widget end = Image.asset(ImagePaths.ribbonEnd, height: height);
    if (flip) end = Transform.scale(scaleX: -1, child: end);
    double m = flip ? 1 : -1;
    return end.animate().move(
        begin: Offset(m * 8, 2),
        end: Offset(m * 32, 10),
        duration: 400.ms,
        curve: Curves.easeOut);
  }
}
