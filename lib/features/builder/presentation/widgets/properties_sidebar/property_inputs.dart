import 'package:flutter/material.dart';

import '../../../../../common/widgets/app_dropdown.dart';
import '../../../../../common/widgets/app_text_field.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/helpers.dart';

class TextPropertyInput extends StatelessWidget {
  final String value;
  final String placeholder;
  final ValueChanged<String> onChanged;

  const TextPropertyInput({
    super.key,
    required this.value,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(value: value, hintText: placeholder, onChanged: onChanged);
  }
}

class SelectPropertyInput extends StatelessWidget {
  final String value;
  final List<String> options;
  final bool isColor;
  final ValueChanged<String> onChanged;

  const SelectPropertyInput({
    super.key,
    required this.value,
    required this.options,
    required this.isColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<String>(
      selectedValue: options.contains(value) ? value : options.first,
      isExpanded: true,
      onSelected: onChanged,
      items: options.map((option) {
        return DropdownItem<String>(
          value: option,
          label: option,
          icon: isColor
              ? Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: parseHexColor(option),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.2), width: 1),
                  ),
                )
              : null,
        );
      }).toList(),
    );
  }
}

class DeleteButton extends StatefulWidget {
  final VoidCallback onTap;

  const DeleteButton({super.key, required this.onTap});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            Icon(
              Icons.delete_outline,
              size: 14,
              color: _isHovered ? const Color(0xFFfca5a5) : const Color(0xFFf87171),
            ),
            const SizedBox(width: 4),
            Text(
              context.l10n.deleteBtnLabel,
              style: context.style.s11w500.copyWith(
                color: _isHovered ? const Color(0xFFfca5a5) : const Color(0xFFf87171),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DuplicateButton extends StatefulWidget {
  final VoidCallback onTap;

  const DuplicateButton({super.key, required this.onTap});

  @override
  State<DuplicateButton> createState() => _DuplicateButtonState();
}

class _DuplicateButtonState extends State<DuplicateButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            Icon(
              Icons.copy_rounded,
              size: 14,
              color: _isHovered
                  ? context.colors.violet.withValues(alpha: 0.8)
                  : context.colors.violet,
            ),
            const SizedBox(width: 4),
            Text(
              context.l10n.duplicateBtnLabel,
              style: context.style.s11w500.copyWith(
                color: _isHovered
                    ? context.colors.violet.withValues(alpha: 0.8)
                    : context.colors.violet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
