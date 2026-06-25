import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/helpers.dart';

class SearchBarElement extends StatelessWidget {
  final Map<String, String> properties;

  const SearchBarElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: parseHexColor(p['bgColor'] ?? '#f3f4f6'),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              p['placeholder'] ?? 'Qidirish...',
              style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF9CA3AF)),
            ),
          ),
        ],
      ),
    );
  }
}
