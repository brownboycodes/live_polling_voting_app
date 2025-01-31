import 'dart:ui';

import 'package:flutter/material.dart';

class ButtonStyling extends ThemeExtension<ButtonStyling> {
  ButtonStyling({
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.borderSide,
    this.padding,
    this.fontSize,
  });

  ///[backgroundColor] is the color of the button
  final Color? backgroundColor;

  ///[textColor] is the color of the text on the button
  final Color? textColor;

  ///[borderRadius] is the border radius of the button
  final BorderRadiusGeometry? borderRadius;

  ///[borderSide] is the border side of the button
  final BorderSide? borderSide;

  ///[padding] is the padding of the button
  final double? padding;

  ///[fontSize] is the font size of the text on the button
  final double? fontSize;

  @override
  ThemeExtension<ButtonStyling> copyWith({
    Color? backgroundColor,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    double? padding,
    double? fontSize,
  }) {
    return ButtonStyling(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderSide: borderSide ?? this.borderSide,
      padding: padding ?? this.padding,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  ThemeExtension<ButtonStyling> lerp(
      covariant ThemeExtension<ButtonStyling>? other, double t) {
    if (other is! ButtonStyling) {
      return this;
    }
    return copyWith(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t),
      borderSide: borderSide ?? other.borderSide,
      padding: lerpDouble(padding, other.padding, t),
      fontSize: lerpDouble(fontSize, other.fontSize, t),
    );
  }

  factory ButtonStyling.defaultStyle() {
    return ButtonStyling(
      backgroundColor: Colors.deepPurple.shade300,
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.deepPurple.shade300),
      padding: 10,
      fontSize: 16,
    );
  }
}
