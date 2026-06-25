import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/helpers.dart';

class InputElement extends StatelessWidget {
  final Map<String, String> properties;

  const InputElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: parseHexColor(p['bgColor'] ?? '#ffffff'),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(double.tryParse(p['radiusTopLeft'] ?? p['borderRadius'] ?? '12') ?? 12),
          topRight: Radius.circular(double.tryParse(p['radiusTopRight'] ?? p['borderRadius'] ?? '12') ?? 12),
          bottomLeft: Radius.circular(double.tryParse(p['radiusBottomLeft'] ?? p['borderRadius'] ?? '12') ?? 12),
          bottomRight: Radius.circular(double.tryParse(p['radiusBottomRight'] ?? p['borderRadius'] ?? '12') ?? 12),
        ),
        border: Border.all(color: parseHexColor(p['borderColor'] ?? '#d1d5db'), width: 1),
      ),
      child: Text(
        p['placeholder'] ?? 'Matn kiriting...',
        style: GoogleFonts.inter(
          fontSize: double.tryParse(p['fontSize'] ?? '16') ?? 16,
          color: const Color(0xFF9ca3af),
        ),
      ),
    );
  }
}
