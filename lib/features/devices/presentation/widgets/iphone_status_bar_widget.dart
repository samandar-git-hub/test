import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class IphoneStatusBarWidget extends StatelessWidget {
  const IphoneStatusBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                '9:41',
                style: context.style.s13w600.copyWith(
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            child: Container(
              width: 110,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.signal_cellular_4_bar, size: 15, color: const Color(0xFF0F172A)),
                  const SizedBox(width: 5),
                  Icon(Icons.battery_full, size: 17, color: const Color(0xFF0F172A)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
