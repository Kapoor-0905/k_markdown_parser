import 'package:flutter/material.dart';

class MarkdownStyles {
  MarkdownStyles({this.color});

  final Color? color;

  Color get textColor => color ?? (Colors.black);

  TextStyle get p => TextStyle(fontSize: 14, color: textColor);
  TextStyle get h1 => TextStyle(fontSize: 32, color: textColor);
  TextStyle get h2 => TextStyle(fontSize: 24, color: textColor);
  TextStyle get h3 => TextStyle(fontSize: 17.5, color: textColor);
  TextStyle get h4 => TextStyle(fontSize: 16, color: textColor);
}
