// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {Key? key, this.size = 22, this.color})
      : super(key: key);
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase().replaceAll('_', '-');
    String path = 'assets/images/common/icons/icon-$i.png';
    //print(path);
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(path,
            width: size,
            height: size,
            color: color ?? AppColors().offWhite,
            filterQuality: FilterQuality.high),
      ),
    );
  }
}

enum AppIcons {
  close,
  prev,
  search,
  timeline,
}
