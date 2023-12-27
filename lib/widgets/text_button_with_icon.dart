import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:flutter/material.dart';

class TextButtonWithIcon extends StatelessWidget {
  const TextButtonWithIcon(
      {super.key,
      required this.iconUrl,
      required this.title,
      required this.onTap,
      this.textColor = Colors.black});
  final String title;
  final String iconUrl;
  final VoidCallback onTap;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        height: 50,
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            CommonText(
              text: title,
              textColor: textColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.75,
            ),
          ],
        ),
      ),
    );
  }
}
