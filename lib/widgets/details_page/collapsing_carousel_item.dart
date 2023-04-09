import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/buttons.dart';

class CollapsingCarouselItem extends StatelessWidget {
  const CollapsingCarouselItem(
      {Key? key,
      required this.child,
      required this.indexOffset,
      required this.width,
      required this.onPressed,
      required this.title})
      : super(key: key);
  final Widget child;
  final int indexOffset;
  final double width;
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    // Calculate offset, this will be subtracted from the bottom padding moving the element downwards
    double vtOffset = 0;
    final tallHeight = width * 1.5;
    if (indexOffset == 1) vtOffset = width * .5;
    if (indexOffset == 2) vtOffset = width * .825;
    if (indexOffset > 2) vtOffset = width;

    final content = AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: indexOffset.abs() <= 2 ? 1 : 0,
      child: _AnimatedTranslate(
        duration: const Duration(milliseconds: 300),
        offset: Offset(0, -tallHeight * .25 + vtOffset),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // Center item is portrait, the others are square
            height: indexOffset == 0 ? tallHeight : width,
            width: width,
            padding: indexOffset == 0
                ? const EdgeInsets.all(0)
                : EdgeInsets.all(width * .1),
            child: child,
          ),
        ),
      ),
    );
    if (indexOffset > 2) return content;
    return AppBtn.basic(
      onPressed: onPressed,
      semanticLabel: title,
      child: content,
    );
  }
}

class _AnimatedTranslate extends StatelessWidget {
  const _AnimatedTranslate({
    Key? key,
    required this.duration,
    required this.offset,
    required this.child,
  }) : super(key: key);
  final Duration duration;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: offset, end: offset),
      duration: duration,
      child: child,
      builder: (_, offset, c) => Transform.translate(offset: offset, child: c),
    );
  }
}
