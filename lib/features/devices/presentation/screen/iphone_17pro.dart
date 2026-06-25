import 'package:flutter/material.dart';
import 'package:visual_buildify/features/devices/presentation/widgets/iphone_status_bar_widget.dart';

import '../../data/models/device_model.dart';

class IPhone17Pro extends StatelessWidget {
  final Widget child;

  const IPhone17Pro({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final config = deviceConfigs[DeviceType.iphone17Pro]!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -2.5,
          top: 130,
          child: Container(
            width: 2.5,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFF4B5563),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                bottomLeft: Radius.circular(2),
              ),
            ),
          ),
        ),
        Positioned(
          left: -2.5,
          top: 175,
          child: Container(
            width: 2.5,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF4B5563),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                bottomLeft: Radius.circular(2),
              ),
            ),
          ),
        ),
        Positioned(
          left: -2.5,
          top: 235,
          child: Container(
            width: 2.5,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF4B5563),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                bottomLeft: Radius.circular(2),
              ),
            ),
          ),
        ),
        Positioned(
          right: -2.5,
          top: 195,
          child: Container(
            width: 2.5,
            height: 68,
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
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(config.bezelRadius),
            border: Border.all(color: const Color(0xFF334155), width: 1.5),
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
                  const IphoneStatusBarWidget(),
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
