import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AndroidStatusBarWidget extends StatelessWidget {
  const AndroidStatusBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '12:30',
              style: context.style.s12w500.copyWith(
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          Positioned(
            top: 14,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi, size: 14, color: const Color(0xFF0F172A)),
                const SizedBox(width: 4),
                Icon(Icons.signal_cellular_4_bar, size: 14, color: const Color(0xFF0F172A)),
                const SizedBox(width: 4),
                Icon(Icons.battery_std, size: 14, color: const Color(0xFF0F172A)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
