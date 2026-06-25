import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/helpers.dart';

class TextElement extends StatelessWidget {
  final Map<String, String> properties;

  const TextElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    return Text(
      p['text'] ?? 'Salom, dunyo!',
      textAlign: parseTextAlign(p['alignment'] ?? 'left'),
      style: GoogleFonts.inter(
        fontSize: double.tryParse(p['fontSize'] ?? '16') ?? 16,
        fontWeight: parseFontWeight(p['fontWeight'] ?? 'normal'),
        color: parseHexColor(p['textColor'] ?? '#111827'),
        height: 1.5,
      ),
    );
  }
}
