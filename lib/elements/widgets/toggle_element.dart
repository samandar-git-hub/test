import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/helpers.dart';

class ToggleElement extends StatelessWidget {
  final Map<String, String> properties;

  const ToggleElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    final isOn = p['defaultState'] == 'on';
    final activeColor = parseHexColor(p['activeColor'] ?? '#3b82f6');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          p['label'] ?? 'Bildirishnomalar',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF374151),
          ),
        ),
        Container(
          width: 48,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isOn ? activeColor : const Color(0xFFd1d5db),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(2),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
