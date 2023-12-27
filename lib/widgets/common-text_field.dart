import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.hintText = '',
      this.label = '',
      this.isPasswordButtonVisible = false,
      this.obscureText = false,
      required this.textEditingController,
      this.suffixIcon,
      this.onShowHideTap,
      this.validator});
  final String? hintText, label;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool isPasswordButtonVisible;
  final bool obscureText;
  final Widget? suffixIcon;

  final void Function()? onShowHideTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          validator: validator,
          controller: textEditingController,
          obscureText: obscureText,
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            suffixIcon: isPasswordButtonVisible
                ? TextButton(
                    onPressed: onShowHideTap,
                    child: suffixIcon!,
                  )
                : null,
            labelText: label,
            labelStyle: const TextStyle(letterSpacing: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ));
  }
}
