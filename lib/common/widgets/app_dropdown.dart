import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_theme.dart';

class DropdownItem<T> {
  final T value;
  final String label;
  final Widget? icon;
  final TextStyle? style;

  const DropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.style,
  });
}

class AppDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<DropdownItem<T>> items;
  final ValueChanged<T> onSelected;
  final String? tooltip;
  final double offset;
  final bool isExpanded;
  final Widget? child;

  const AppDropdown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.onSelected,
    this.tooltip,
    this.offset = 44,
    this.isExpanded = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    // Resolve current item if selectedValue is not null
    final currentItem = selectedValue != null
        ? items.firstWhere(
            (item) => item.value == selectedValue,
            orElse: () => items.first,
          )
        : items.first;

    return PopupMenuButton<T>(
      tooltip: tooltip,
      offset: Offset(0, offset),
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colors.borderDark, width: 1),
      ),
      initialValue: selectedValue,
      onSelected: onSelected,
      itemBuilder: (context) {
        return items.map((item) {
          final isSelected = selectedValue != null && item.value == selectedValue;
          return PopupMenuItem<T>(
            value: item.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  item.icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  item.label,
                  style: item.style ?? GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? colors.textPrimary : colors.textSecondary,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 24),
                  Icon(Icons.check, size: 16, color: colors.textPrimary),
                ],
              ],
            ),
          );
        }).toList();
      },
      child: child ?? Container(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.borderDark, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (currentItem.icon != null) ...[
              currentItem.icon!,
              const SizedBox(width: 8),
            ],
            if (isExpanded)
              Expanded(
                child: Text(
                  currentItem.label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              )
            else
              Text(
                currentItem.label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            const SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down, size: 16, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }
}
