import 'package:flutter/material.dart';
import 'package:visual_buildify/common/hover/custom_hover.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const CustomButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomHover(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: child),
    );
  }
}
