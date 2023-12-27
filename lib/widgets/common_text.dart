import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {super.key,
      required this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.fontFamily = 'Inter',
      this.letterSpacing = 0.5,
      this.textColor = Colors.black});
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
