import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_theme.dart';

class AppTextField extends StatefulWidget {
  final String? value;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final double? width;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final bool isDense;

  const AppTextField({
    super.key,
    this.value,
    this.controller,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.width,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.borderRadius = 12,
    this.isDense = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && widget.value != _controller.text && widget.controller == null) {
      final oldSelection = _controller.selection;
      _controller.text = widget.value!;
      try {
        _controller.selection = oldSelection;
      } catch (_) {
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget textField = TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: colors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: colors.violet,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(fontSize: 14, color: colors.textMuted),
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: widget.prefixIconConstraints,
        filled: true,
        fillColor: colors.surface,
        contentPadding: widget.contentPadding,
        isDense: widget.isDense,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: colors.borderDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: colors.borderDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: colors.violet, width: 1.5),
        ),
      ),
    );

    if (widget.width != null) {
      return SizedBox(width: widget.width, child: textField);
    }
    return textField;
  }
}
