import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/helpers.dart';

class CardElement extends StatelessWidget {
  final Map<String, String> properties;

  const CardElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    final bgColor = parseHexColor(p['bgColor'] ?? '#ffffff');
    final isDark = bgColor.computeLuminance() < 0.5;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(double.tryParse(p['paddingAll'] ?? '16') ?? 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(double.tryParse(p['radiusTopLeft'] ?? p['borderRadius'] ?? '16') ?? 16),
          topRight: Radius.circular(double.tryParse(p['radiusTopRight'] ?? p['borderRadius'] ?? '16') ?? 16),
          bottomLeft: Radius.circular(double.tryParse(p['radiusBottomLeft'] ?? p['borderRadius'] ?? '16') ?? 16),
          bottomRight: Radius.circular(double.tryParse(p['radiusBottomRight'] ?? p['borderRadius'] ?? '16') ?? 16),
        ),
        border: isDark ? null : Border.all(color: const Color(0xFFf3f4f6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p['title'] ?? 'Karta sarlavhasi',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            p['description'] ?? 'Bu yerda tavsif yozing',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.white.withValues(alpha: 0.7) : const Color(0xFF6b7280),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
