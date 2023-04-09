import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const Duration kDefaultDuration = Duration(milliseconds: 300);

  static Route<T> dialog<T>(Widget child,
      {Duration duration = kDefaultDuration, bool opaque = false}) {
    // Use cupertino routes for all dialogs so we get the 'swipe right to go back' behavior
    if (opaque) {
      return CupertinoPageRoute(builder: (_) => child);
    }

    // SB: Removed this in favor of Cupertino routes, we could restore with a `useFade` option
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      opaque: opaque,
      fullscreenDialog: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}

// Navigator class
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == "/") return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
  }
}
