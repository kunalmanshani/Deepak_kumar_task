import 'package:flutter/material.dart';

class CommonThemeScafold extends StatelessWidget {
  const CommonThemeScafold({
    super.key,
    required this.body,
  });
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        clipBehavior: Clip.hardEdge,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgImage.jpg'))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: body,
        ),
      ),
    );
  }
}
