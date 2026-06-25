import 'package:flutter/material.dart';
import 'package:visual_buildify/core/extensions/context_extensions.dart';

class CustomHover extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CustomHover({super.key, required this.child, this.padding});

  @override
  State<CustomHover> createState() => _CustomHoverState();
}

class _CustomHoverState extends State<CustomHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: _isHovered ? context.colors.hover : context.colors.transparent,
        ),
        child: widget.child,
      ),
    );
  }
}
