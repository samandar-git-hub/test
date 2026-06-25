import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AppControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isActive;

  const AppControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    final colors = context.colors;

    Widget button = Container(
      decoration: BoxDecoration(
        color: isActive ? colors.violet.withValues(alpha: 0.15) : colors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? colors.violet : colors.borderDark, width: 1),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16),
        color: isDisabled ? colors.textMuted : (isActive ? colors.violet : colors.textPrimary),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        onPressed: onPressed,
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
