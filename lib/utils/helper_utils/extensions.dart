import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/universal_platforms/platforms.dart';
import 'package:pet_adoption_app/utils/helper_utils/functions.dart';

extension SizedContext on BuildContext {
  double get pixelsPerInch =>
      UniversalPlatform.isAndroid || UniversalPlatform.isIOS ? 150 : 96;

  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  /// Returns diagonal screen pixels
  double get diagonalPx {
    final Size s = sizePx;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  /// Returns pixel size in Inches
  Size get sizeInches {
    final Size pxSize = sizePx;
    return Size(pxSize.width / pixelsPerInch, pxSize.height / pixelsPerInch);
  }

  /// Returns screen width in Inches
  double get widthInches => sizeInches.width;

  /// Returns screen height in Inches
  double get heightInches => sizeInches.height;

  /// Returns screen diagonal in Inches
  double get diagonalInches => diagonalPx / pixelsPerInch;

  /// Returns fraction (0-1) of screen width in pixels
  double widthPct(double fraction) => fraction * widthPx;

  /// Returns fraction (0-1) of screen height in pixels
  double heightPct(double fraction) => fraction * heightPx;

  // Naviagtors
  Future<dynamic> push(Widget child) =>
      Navigator.of(this).push(createRoute(child));

  Future<dynamic> pushReplacement(Widget child) =>
      Navigator.of(this).pushReplacement(createRoute(child));
}

extension NumExtensions on num {
  DateTime get dateFromSeconds => DateTime.fromMillisecondsSinceEpoch(
        (this * 1000).toInt(),
      );
}

extension DateTimeExtensions on DateTime {
  String get monthAndYear {
    final DateFormat formatter = DateFormat.yMMM();
    return formatter.format(this);
  }

  String get dayMonthAndYear {
    final DateFormat formatter = DateFormat.yMMMMd();
    return formatter.format(this);
  }
}

extension UIExtensions on num {
  // Spacing
  SizedBox get verticalSpacing => SizedBox(height: toDouble());
  SizedBox get horizontalSpacing => SizedBox(width: toDouble());
  SizedBox get spacing => SizedBox(width: toDouble(), height: toDouble());

  // BorderRadius
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  // EdgeInsets
  EdgeInsets get edgeInsets => EdgeInsets.all(toDouble());
  EdgeInsets get verticalEdgeInsets =>
      EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get horizontalEdgeInsets =>
      EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get rightEdgeInsets => EdgeInsets.only(right: toDouble());
  EdgeInsets get leftEdgeInsets => EdgeInsets.only(left: toDouble());
  EdgeInsets get topEdgeInsets => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottomEdgeInsets => EdgeInsets.only(bottom: toDouble());
}

extension UIListExtensions on List<num> {
  // EdgeInsets
  EdgeInsets? get edgeInsets {
    EdgeInsets? value;
    if (length == 1) {
      value = EdgeInsets.all(first.toDouble());
    } else if (length == 2) {
      value = EdgeInsets.symmetric(
        vertical: first.toDouble(),
        horizontal: last.toDouble(),
      );
    } else if (length == 3) {
      value = EdgeInsets.fromLTRB(
        this[1].toDouble(),
        first.toDouble(),
        this[1].toDouble(),
        last.toDouble(),
      );
    } else if (length == 4) {
      value = EdgeInsets.fromLTRB(
        first.toDouble(),
        this[1].toDouble(),
        this[2].toDouble(),
        last.toDouble(),
      );
    }
    return value;
  }
}

extension StringExtensions on String? {
  bool get isEmpty => this == null || this?.trim().isEmpty == true;
  bool get isNotEmpty => !isEmpty;
  bool get isLink => this == null
      ? false
      : this!.contains(
          RegExp(
              r'^(https?:\/\/)?([\w\d_-]+)\.([\w\d_\.-]+)\/?\??([^#\n\r]*)?#?([^\n\r]*)'),
        );
  String truncateWithEllipsis(int cutoff) {
    if (this == null) {
      return "";
    }
    return (this!.length <= cutoff)
        ? this!
        : '${this!.substring(0, cutoff)}...';
  }
}

extension DoubleExtensions on double {
  String get formattedRupeeString {
    NumberFormat indianRupeesFormat = NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 2, // change it to get decimal places
      symbol: '₹',
    );
    return indianRupeesFormat.format(this);
  }
}
