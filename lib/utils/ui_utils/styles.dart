import 'package:flutter/material.dart';
import 'colors.dart';

@immutable
class AppStyle {
  AppStyle({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;
    if (shortestSide > tabletXl) {
      scale = 1.25;
    } else if (shortestSide > tabletLg) {
      scale = 1.15;
    } else if (shortestSide > tabletSm) {
      scale = 1;
    } else if (shortestSide > phoneLg) {
      scale = .9; // phone
    } else {
      scale = .85; // small phone
    }
    debugPrint('screenSize=$screenSize, scale=$scale');
  }

  late final double scale;

  late final AppShadows shadows = AppShadows();

  /// Padding and margin values
  late final AppInsets insets = AppInsets(scale);

  /// Text styles
  late final AppText text = AppText(scale);

  /// Animation Durations
  final AppTimes times = AppTimes();

  /// Shared sizes
  late final AppSizes sizes = AppSizes();

  late final AppGradients gradients = AppGradients();

  late final AppColorFilters colorFilters = AppColorFilters();
}

@immutable
class AppText {
  AppText(this._scale);
  final double _scale;

  late final TextStyle h1 = _createFont(sizePx: 64, heightPx: 62);
  late final TextStyle h2 = _createFont(sizePx: 32, heightPx: 46);
  late final TextStyle h3 =
      _createFont(sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final TextStyle h4 = _createFont(
      sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late final TextStyle title1 =
      _createFont(sizePx: 16, heightPx: 26, spacingPc: 5);
  late final TextStyle title2 = _createFont(sizePx: 14, heightPx: 16.38);

  late final TextStyle body = _createFont(sizePx: 16, heightPx: 26);
  late final TextStyle bodyBold =
      _createFont(sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late final TextStyle bodySmall = _createFont(sizePx: 14, heightPx: 23);
  late final TextStyle bodySmallBold =
      _createFont(sizePx: 14, weight: FontWeight.w500);

  late final TextStyle quote1 = _createFont(
      sizePx: 32, heightPx: 40, weight: FontWeight.w600, spacingPc: -3);
  late final TextStyle quote2 =
      _createFont(sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late final TextStyle quote2Sub =
      _createFont(sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late final TextStyle caption =
      _createFont(sizePx: 14, heightPx: 20, weight: FontWeight.w500)
          .copyWith(fontStyle: FontStyle.italic);

  late final TextStyle callout =
      _createFont(sizePx: 16, heightPx: 26, weight: FontWeight.w600)
          .copyWith(fontStyle: FontStyle.italic);
  late final TextStyle btn = _createFont(
      sizePx: 14, weight: FontWeight.w500, spacingPc: 2, heightPx: 14);
  // Labels

  late final TextStyle smallBold = _createFont(
    sizePx: 14,
    weight: FontWeight.w500,
    fontColor: AppColors().body,
  );

  late final TextStyle miniWhiteBold = _createFont(
    sizePx: 12,
    weight: FontWeight.w500,
    fontColor: AppColors().white,
  );
  late final TextStyle largeFont = _createFont(
    sizePx: 16,
    fontColor: AppColors().body,
  );

  TextStyle _createFont({
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
    Color? fontColor,
  }) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return TextStyle(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : null,
      letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : null,
      fontWeight: weight,
      color: fontColor,
    );
  }
}

@immutable
class AppTimes {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

class AppSizes {
  double get maxContentWidth1 => 800;
  double get maxContentWidth2 => 600;
  double get maxContentWidth3 => 500;
  final Size minAppSize = const Size(380, 675);
}

@immutable
class AppInsets {
  AppInsets(this._scale);
  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class AppShadows {
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(.25),
        offset: const Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 2),
        blurRadius: 2),
  ];
  final whiteText = [
    const Shadow(color: Colors.white, offset: Offset(0, 2), blurRadius: 2),
  ];
  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 4),
        blurRadius: 6),
  ];
}

@immutable
class AppGradients {
  final RadialGradient radialGradient = RadialGradient(
    center: const Alignment(0, 0),
    colors: [
      AppColors().accent1,
      AppColors().accent2,
    ],
    radius: 1.0,
  );
  final RadialGradient radialGreyGradient = RadialGradient(
    center: const Alignment(0, 0),
    colors: [
      AppColors().greyMedium,
      AppColors().white,
    ],
    radius: 1.0,
  );
}

@immutable
class AppColorFilters {
  final ColorFilter coloredFilter = const ColorFilter.mode(
    Colors.transparent,
    BlendMode.multiply,
  );
  final ColorFilter greyFilter = const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}
