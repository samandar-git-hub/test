import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/helpers.dart';

class ButtonElement extends StatelessWidget {
  final Map<String, String> properties;

  const ButtonElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: double.tryParse(p['paddingH'] ?? '16') ?? 16,
        vertical: double.tryParse(p['paddingV'] ?? '14') ?? 14,
      ),
      decoration: BoxDecoration(
        color: parseHexColor(p['bgColor'] ?? '#3b82f6'),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(double.tryParse(p['radiusTopLeft'] ?? p['borderRadius'] ?? '12') ?? 12),
          topRight: Radius.circular(double.tryParse(p['radiusTopRight'] ?? p['borderRadius'] ?? '12') ?? 12),
          bottomLeft: Radius.circular(double.tryParse(p['radiusBottomLeft'] ?? p['borderRadius'] ?? '12') ?? 12),
          bottomRight: Radius.circular(double.tryParse(p['radiusBottomRight'] ?? p['borderRadius'] ?? '12') ?? 12),
        ),
        boxShadow: [
          BoxShadow(
            color: parseHexColor(p['bgColor'] ?? '#3b82f6').withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          p['text'] ?? 'Tugma',
          style: GoogleFonts.inter(
            fontSize: double.tryParse(p['fontSize'] ?? '16') ?? 16,
            fontWeight: parseFontWeight(p['fontWeight'] ?? 'semibold'),
            color: parseHexColor(p['textColor'] ?? '#ffffff'),
          ),
        ),
      ),
    );
  }
}
