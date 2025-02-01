import 'package:flutter/material.dart';

class PollOptionStyle extends ThemeExtension<PollOptionStyle>{

  PollOptionStyle({this.textStyle,this.voteCountStyle,this.progressIndicatorColor,this.progressIndicatorBackgroundColor});
  TextStyle? textStyle;
  TextStyle? voteCountStyle;
  Color? progressIndicatorColor;
  Color? progressIndicatorBackgroundColor;

  @override
  ThemeExtension<PollOptionStyle> copyWith({
    TextStyle? textStyle,
  TextStyle? voteCountStyle,
  Color? progressIndicatorColor,
  Color? progressIndicatorBackgroundColor
  }) {
    return PollOptionStyle(
      textStyle: textStyle ?? this.textStyle,
      voteCountStyle:  voteCountStyle ?? this.voteCountStyle,
      progressIndicatorColor:  progressIndicatorColor ?? this.progressIndicatorColor,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor ?? this.progressIndicatorBackgroundColor
    );
  }

  @override
  ThemeExtension<PollOptionStyle> lerp(
      covariant ThemeExtension<PollOptionStyle>? other, double t) {
    if (other is! PollOptionStyle) {
      return this;
    }
    return copyWith(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      voteCountStyle:  TextStyle.lerp(textStyle, other.textStyle, t),
      progressIndicatorColor: Color.lerp(progressIndicatorColor, other.progressIndicatorColor, t),
      progressIndicatorBackgroundColor: Color.lerp(progressIndicatorBackgroundColor, other.progressIndicatorBackgroundColor, t)
    );
  }

  factory PollOptionStyle.defaultStyle() {
    return PollOptionStyle(
      textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
      voteCountStyle: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
      progressIndicatorBackgroundColor: Colors.grey.shade300,
      progressIndicatorColor: Colors.purple.shade300
    );
  }
}