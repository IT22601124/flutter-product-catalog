import 'package:flutter/material.dart';

class ColorResources {
  static const Color primaryColor = Colors.deepPurple;
  static const Color secondaryColor = Colors.green;
  static const Color errorColor = Colors.red;
  static const Color priceColor = Colors.green;
  
  static Color getPrimaryContainer(BuildContext context) => 
      Theme.of(context).colorScheme.primaryContainer;
  
  static Color getOnPrimaryContainer(BuildContext context) => 
      Theme.of(context).colorScheme.onPrimaryContainer;
}
