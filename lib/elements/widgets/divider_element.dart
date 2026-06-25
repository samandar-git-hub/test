import 'package:flutter/material.dart';

import '../../core/utils/helpers.dart';

class DividerElement extends StatelessWidget {
  final Map<String, String> properties;

  const DividerElement({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final p = properties;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: double.tryParse(p['marginV'] ?? '12') ?? 12),
      child: Container(
        height: double.tryParse(p['height'] ?? '1') ?? 1,
        decoration: BoxDecoration(
          color: parseHexColor(p['color'] ?? '#e5e7eb'),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
