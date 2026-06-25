import 'package:flutter/material.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';

class TransparentButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  final IconData? icon;
  final bool iconFirst;
  final Axis axis;
  final Widget? child;

  const TransparentButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.iconFirst = true,
    this.axis = Axis.horizontal,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget buttonContent;
    if (child != null) {
      buttonContent = child!;
    } else {
      final List<Widget> children = [];
      
      final textWidget = text != null
          ? Text(
              text!,
              style: context.style.s10w600.copyWith(color: colors.textMuted),
            )
          : null;

      final iconWidget = icon != null
          ? Icon(
              icon,
              size: 18,
              color: colors.textPrimary,
            )
          : null;

      if (iconWidget != null && textWidget != null) {
        if (iconFirst) {
          children.addAll([
            iconWidget,
            SizedBox(
              width: axis == Axis.horizontal ? 4 : 0,
              height: axis == Axis.vertical ? 2 : 0,
            ),
            textWidget,
          ]);
        } else {
          children.addAll([
            textWidget,
            SizedBox(
              width: axis == Axis.horizontal ? 4 : 0,
              height: axis == Axis.vertical ? 2 : 0,
            ),
            iconWidget,
          ]);
        }
      } else if (iconWidget != null) {
        children.add(iconWidget);
      } else if (textWidget != null) {
        children.add(textWidget);
      }

      if (axis == Axis.horizontal) {
        buttonContent = Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        );
      } else {
        buttonContent = Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        );
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: buttonContent,
        ),
      ),
    );
  }
}