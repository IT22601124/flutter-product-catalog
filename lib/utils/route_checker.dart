import 'package:flutter/material.dart';

class RouteChecker {
  static void logRoute(RouteSettings settings) {
    debugPrint('Navigating to: ${settings.name}');
  }

  static bool isCurrentRoute(BuildContext context, String routeName) {
    return ModalRoute.of(context)?.settings.name == routeName;
  }
}
