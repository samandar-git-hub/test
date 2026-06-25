import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visual_buildify/common/hover/custom_hover.dart';

import '../../../core/theme/app_theme.dart';

class CustomDropdownItem<T> {
  final T value;
  final String label;

  const CustomDropdownItem({required this.value, required this.label});
}

class CustomDropDown<T> extends StatefulWidget {
  final String? label;
  final List<CustomDropdownItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T> onSelected;

  const CustomDropDown({
    super.key,
    this.label,
    required this.items,
    this.selectedValue,
    required this.onSelected,
  });

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.items.firstWhere(
      (item) => item.value == widget.selectedValue,
      orElse: () => widget.items.first,
    );

    return CustomHover(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: PopupMenuButton<T>(
        tooltip: '',
        offset: const Offset(0, 0),
        color: context.colors.surface,
        initialValue: widget.selectedValue,
        onSelected: widget.onSelected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: context.colors.borderDark, width: 1),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: context.style.s12w500.copyWith(color: context.colors.textMuted),
              ),
              const Gap(6),
            ],
            Text(selectedItem.label, style: context.style.s12w500),
            const Gap(6),
            Icon(Icons.keyboard_arrow_down, size: 16, color: context.colors.textMuted),
          ],
        ),

        itemBuilder: (context) {
          return widget.items.map((item) {
            final isSelected = widget.selectedValue == item.value;
            return PopupMenuItem<T>(
              value: item.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.label,
                    style: context.style.s12w400.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? context.colors.textPrimary : context.colors.textSecondary,
                    ),
                  ),
                  if (isSelected) ...[
                    const Gap(20),
                    Icon(Icons.check, size: 16, color: context.colors.textPrimary),
                  ],
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
