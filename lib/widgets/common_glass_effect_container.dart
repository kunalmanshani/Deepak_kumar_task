import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CommonGlassEffectContainer extends StatelessWidget {
  const CommonGlassEffectContainer({
    super.key,
    required this.child,
    required this.height,
  });
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      height: height,
      constraints: const BoxConstraints(minHeight: 200),
      width: double.maxFinite,
      borderRadius: 12,
      blur: 10,
      border: 0,
      linearGradient: LinearGradient(
        colors: [
          // Colors.grey.withOpacity(0.3),
          // Colors.white.withOpacity(0.25),
          Colors.black.withOpacity(0.35),
          Colors.black.withOpacity(0.25),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.black.withOpacity(0.35),
          Colors.black.withOpacity(0.25),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: child,
      ),
    );
  }
}
