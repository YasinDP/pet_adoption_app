// ignore_for_file: constant_identifier_names

import 'package:pet_adoption_app/universal_platforms/platform_locator.dart'
    if (dart.library.io) 'package:pet_adoption_app/universal_platforms/io_platforms.dart';

abstract class UniversalPlatform {
  static bool get isWeb =>
      currentUniversalPlatform == UniversalPlatformType.Web;
  static bool get isMacOS =>
      currentUniversalPlatform == UniversalPlatformType.MacOS;
  static bool get isWindows =>
      currentUniversalPlatform == UniversalPlatformType.Windows;
  static bool get isLinux =>
      currentUniversalPlatform == UniversalPlatformType.Linux;
  static bool get isAndroid =>
      currentUniversalPlatform == UniversalPlatformType.Android;
  static bool get isIOS =>
      currentUniversalPlatform == UniversalPlatformType.IOS;
  static bool get isFuchsia =>
      currentUniversalPlatform == UniversalPlatformType.Fuchsia;

  static bool get isDesktop => isLinux || isMacOS || isWindows;
  static bool get isDesktopOrWeb => isDesktop;
}

enum UniversalPlatformType { Web, Windows, Linux, MacOS, Android, Fuchsia, IOS }
