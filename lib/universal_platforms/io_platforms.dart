import 'dart:io';

import 'package:pet_adoption_app/universal_platforms/platforms.dart';

//Override default method, to provide .io access
UniversalPlatformType get currentUniversalPlatform {
  if (Platform.isWindows) return UniversalPlatformType.Windows;
  if (Platform.isFuchsia) return UniversalPlatformType.Fuchsia;
  if (Platform.isMacOS) return UniversalPlatformType.MacOS;
  if (Platform.isLinux) return UniversalPlatformType.Linux;
  if (Platform.isIOS) return UniversalPlatformType.IOS;
  return UniversalPlatformType.Android;
}
