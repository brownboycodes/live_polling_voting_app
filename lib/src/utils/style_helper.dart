import 'package:flutter/material.dart';

class StyleHelper {
  static T getTheme<T extends ThemeExtension<T>>(
      {required BuildContext context, required T defaultTheme}) {
    try {
      // Retrieve the theme extension from the current theme, or use the `of` method to get a default instance
      final T themeData = Theme.of(context).extension<T>() ?? defaultTheme;
      return themeData;
    } catch (e) {
      throw ArgumentError(
          '$T is not a valid ThemeExtension', 'ThemeExtension not found');
    }
  }
}
