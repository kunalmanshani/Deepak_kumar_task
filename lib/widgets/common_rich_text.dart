import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommonRichText extends StatelessWidget {
  const CommonRichText(
      {super.key,
      this.onTap,
      required this.text,
      required this.clickableText,
      this.letterSpacing,
      this.textColor,
      this.fontWeight1 = FontWeight.w400,
      this.fontWeight2 = FontWeight.w400,
      this.fontSize = 14,
      this.clickableTextColor});
  final void Function()? onTap;
  final String? text, clickableText;
  final Color? textColor, clickableTextColor;
  final double? fontSize, letterSpacing;
  final FontWeight? fontWeight1, fontWeight2;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: text,
      style: TextStyle(
          fontWeight: fontWeight1,
          fontSize: fontSize,
          color: textColor,
          letterSpacing: letterSpacing),
      children: [
        TextSpan(
            text: clickableText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: TextStyle(
                fontSize: fontSize,
                color: clickableTextColor ?? const Color(0xff01C38E),
                letterSpacing: letterSpacing,
                fontWeight: fontWeight2)),
      ],
    ));
  }
}
