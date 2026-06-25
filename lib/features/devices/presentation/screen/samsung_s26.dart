import 'package:flutter/material.dart';
import 'package:visual_buildify/features/devices/presentation/widgets/android_status_bar_widget.dart';

import '../../data/models/device_model.dart';

class SamsungS26 extends StatelessWidget {
  final Widget child;

  const SamsungS26({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final config = deviceConfigs[DeviceType.samsungS26]!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -2.5,
          top: 150,
          child: Container(
            width: 2.5,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF4B5563),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
          ),
        ),
        Positioned(
          right: -2.5,
          top: 225,
          child: Container(
            width: 2.5,
            height: 35,
            decoration: const BoxDecoration(
              color: Color(0xFF4B5563),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(config.bezelPadding),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(config.bezelRadius),
            border: Border.all(color: const Color(0xFF475569), width: 1.5),
          ),
          child: Container(
            width: config.width,
            height: config.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(config.screenRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(config.screenRadius),
              child: Column(
                children: [
                  const AndroidStatusBarWidget(),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
