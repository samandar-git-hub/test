import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_buildify/common/hover/custom_hover.dart';
import 'package:visual_buildify/core/utils/helpers.dart';

import '../../../core/theme/app_theme.dart';

class ColorDropdownItem<T> {
  final T value;
  final String label;

  const ColorDropdownItem({required this.value, required this.label});
}

class ColorDropDown<T> extends StatefulWidget {
  final String? label;
  final List<ColorDropdownItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T> onSelected;

  const ColorDropDown({
    super.key,
    this.label,
    required this.items,
    this.selectedValue,
    required this.onSelected,
  });

  @override
  State<ColorDropDown<T>> createState() => _ColorDropDownState<T>();
}

class _ColorDropDownState<T> extends State<ColorDropDown<T>> {
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
        constraints: const BoxConstraints(maxWidth: 300),
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
            Text(widget.label ?? 'Color:', style: context.style.s12w500.copyWith(color: context.colors.textMuted)),
            const Gap(6),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: parseHexColor(selectedItem.value.toString()),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: context.colors.borderDark, width: 1),
              ),
            ),
            const Gap(6),
            Text(selectedItem.label, style: context.style.s12w500),
            const Gap(6),
            Icon(Icons.keyboard_arrow_down, size: 16, color: context.colors.textMuted),
          ],
        ),

        itemBuilder: (context) {
          return [
            PopupMenuItem<T>(
              enabled: false,
              padding: EdgeInsets.all(10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.items.map((item) {
                  final isSelected = widget.selectedValue == item.value;
                  final color = parseHexColor(item.value.toString());
                  return GestureDetector(
                    onTap: () {
                      context.pop(item.value);
                    },
                    child: Container(
                      width: isSelected ? 25 : 35,
                      height: isSelected ? 25 : 35,
                      margin: EdgeInsets.all(isSelected ? 5 : 0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isSelected
                          ? Icon(Icons.check, size: 16, color: context.colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ),
          ];
        },
      ),
    );
  }
}


