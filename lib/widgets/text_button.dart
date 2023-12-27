import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  const CommonTextButton(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.textColor = Colors.white});
  final VoidCallback onTap;
  final String buttonText;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff01C38E)),
          child: CommonText(
            textColor: textColor,
            text: buttonText,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.75,
          )),
    );
  }
}
