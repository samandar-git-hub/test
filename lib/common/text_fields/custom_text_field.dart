import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visual_buildify/common/hover/custom_hover.dart';
import 'package:visual_buildify/core/extensions/context_extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.text,
    this.label,
    this.border = false,
    this.padding,
    this.inputFormatters,
    this.onChanged,
  });

  final String? text;
  final String? label;
  final bool border;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != _controller.text) {
      final oldSelection = _controller.selection;
      _controller.text = widget.text ?? '';
      try {
        _controller.selection = oldSelection;
      } catch (_) {
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHover(
      child: TextField(
        controller: _controller,
        style: context.style.s14w500,
        decoration: widget.border
            ? InputDecoration(
                contentPadding: widget.padding ?? const EdgeInsets.all(6),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.colors.borderDark),
                ),
                prefixIcon: widget.label != null
                    ? Text(
                        widget.label!,
                        style: context.style.s12w500.copyWith(color: context.colors.textMuted),
                      )
                    : null,
              )
            : InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: widget.padding ?? const EdgeInsets.all(6),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIcon: widget.label != null
                    ? Text(
                        widget.label!,
                        style: context.style.s12w500.copyWith(color: context.colors.textMuted),
                      )
                    : null,
              ),
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
      ),
    );
  }
}
