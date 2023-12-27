import 'package:deepak_kumar_task/widgets/common_text.dart';
import 'package:flutter/material.dart';

snackBarWidget(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CommonText(
    text: message,
    textColor: Colors.white,
  )));
}
