import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isGradient;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.width,
    this.height = 50,
    this.isGradient = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final double effectiveBorderRadius = 14;

    Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: textColor ?? (isGradient ? Colors.white : colors.textPrimary),
          ),
        ),
        if (icon != null) ...[
          const SizedBox(width: 8),
          Icon(
            icon,
            size: 18,
            color: textColor ?? (isGradient ? Colors.white : colors.textPrimary),
          ),
        ],
      ],
    );

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isGradient ? Colors.transparent : (backgroundColor ?? colors.surface),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
      ),
      padding: EdgeInsets.zero,
    );

    Widget innerButton = ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: buttonChild,
    );

    Widget decoratedContainer;
    if (isGradient) {
      decoratedContainer = Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          gradient: LinearGradient(
            colors: [colors.violet, colors.blue],
          ),
          boxShadow: [
            BoxShadow(
              color: colors.violet.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: innerButton,
      );
    } else {
      decoratedContainer = Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: Border.all(
            color: backgroundColor == null ? colors.borderDark : Colors.transparent,
            width: 1,
          ),
        ),
        child: innerButton,
      );
    }

    return decoratedContainer;
  }
}
