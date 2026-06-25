import 'package:flutter/services.dart';

class MinMaxIntValueFormatter extends TextInputFormatter {
  final int min;
  final int max;

  MinMaxIntValueFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue(
        text: min.toString(),
        selection: TextSelection.collapsed(offset: min.toString().length),
      );
    }

    String text = newValue.text;
    if (text.length > 1 && text.startsWith('0')) {
      text = int.tryParse(text)?.toString() ?? min.toString();
    }

    final val = int.tryParse(text);
    if (val != null) {
      if (val > max) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.collapsed(offset: max.toString().length),
        );
      }
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
