import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_buildify/common/buttons/transparent_button.dart';
import 'package:visual_buildify/common/text_fields/custom_text_field.dart';
import 'package:visual_buildify/common/utils/input_formatters.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';

import '../../../../../elements/models/builder_models.dart';
import '../../../../devices/data/models/device_model.dart';
import '../../../../devices/presentation/bloc/device_bloc.dart';
import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';

class PositionRadiusEditor extends StatelessWidget {
  final CanvasElement activeElement;

  const PositionRadiusEditor({super.key, required this.activeElement});

  @override
  Widget build(BuildContext context) {
    final String baseRadius = activeElement.properties['borderRadius'] ?? '0';
    final String tlVal = activeElement.properties['radiusTopLeft'] ?? baseRadius;
    final String trVal = activeElement.properties['radiusTopRight'] ?? baseRadius;
    final String blVal = activeElement.properties['radiusBottomLeft'] ?? baseRadius;
    final String brVal = activeElement.properties['radiusBottomRight'] ?? baseRadius;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.borderDark, width: 1),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Button
                TransparentButton(
                  text: 'TOP',
                  icon: Icons.keyboard_arrow_up_rounded,
                  axis: Axis.vertical,
                  iconFirst: true,
                  onTap: () {
                    final currentY = double.tryParse(activeElement.properties['y'] ?? '0') ?? 0.0;
                    final deviceState = context.read<DeviceBloc>().state;
                    final config = deviceConfigs[deviceState.selectedDevice]!;
                    final double height =
                        double.tryParse(activeElement.properties['height'] ?? '80') ?? 80.0;
                    final page = context.read<BuilderBloc>().state.activePage;
                    double screenHeight = config.height - config.statusBarHeight;
                    
                    final area = activeElement.properties['area'];
                    double minY = 0.0;
                    double maxY = 0.0;
                    
                    if (area == 'appBar') {
                      maxY = math.max(0.0, 40.0 - height);
                    } else if (area == 'bottomNav') {
                      maxY = math.max(0.0, 56.0 - height);
                    } else {
                      if (page.showBottomNav) screenHeight -= 56;
                      if (page.showAppBar) minY = 40.0;
                      maxY = math.max(minY, screenHeight - height);
                    }
                    
                    final newY = (currentY - 1).clamp(minY, maxY);
                    context.read<BuilderBloc>().add(
                      UpdateElementLayoutEvent(activeElement.id, y: newY),
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Button
                    TransparentButton(
                      text: 'LEFT',
                      icon: Icons.keyboard_arrow_left_rounded,
                      axis: Axis.horizontal,
                      iconFirst: true,
                      onTap: () {
                        final currentX =
                            double.tryParse(activeElement.properties['x'] ?? '0') ?? 0.0;
                        final deviceState = context.read<DeviceBloc>().state;
                        final config = deviceConfigs[deviceState.selectedDevice]!;
                        final double width =
                            double.tryParse(activeElement.properties['width'] ?? '200') ?? 200.0;
                        final maxX = math.max(0.0, config.width - width);
                        final newX = (currentX - 1).clamp(0.0, maxX);
                        context.read<BuilderBloc>().add(
                          UpdateElementLayoutEvent(activeElement.id, x: newX),
                        );
                      },
                    ),

                    // Right Button
                    TransparentButton(
                      text: 'RIGHT',
                      icon: Icons.keyboard_arrow_right_rounded,
                      axis: Axis.horizontal,
                      iconFirst: false,
                      onTap: () {
                        final currentX =
                            double.tryParse(activeElement.properties['x'] ?? '0') ?? 0.0;
                        final deviceState = context.read<DeviceBloc>().state;
                        final config = deviceConfigs[deviceState.selectedDevice]!;
                        final double width =
                            double.tryParse(activeElement.properties['width'] ?? '200') ?? 200.0;
                        final maxX = math.max(0.0, config.width - width);
                        final newX = (currentX + 1).clamp(0.0, maxX);
                        context.read<BuilderBloc>().add(
                          UpdateElementLayoutEvent(activeElement.id, x: newX),
                        );
                      },
                    ),
                  ],
                ),

                // Bottom Button
                TransparentButton(
                  text: 'BOTTOM',
                  icon: Icons.keyboard_arrow_down_rounded,
                  axis: Axis.vertical,
                  iconFirst: false,
                  onTap: () {
                    final currentY = double.tryParse(activeElement.properties['y'] ?? '0') ?? 0.0;
                    final deviceState = context.read<DeviceBloc>().state;
                    final config = deviceConfigs[deviceState.selectedDevice]!;
                    final double height =
                        double.tryParse(activeElement.properties['height'] ?? '80') ?? 80.0;
                    final page = context.read<BuilderBloc>().state.activePage;
                    double screenHeight = config.height - config.statusBarHeight;
                    
                    final area = activeElement.properties['area'];
                    double minY = 0.0;
                    double maxY = 0.0;
                    
                    if (area == 'appBar') {
                      maxY = math.max(0.0, 40.0 - height);
                    } else if (area == 'bottomNav') {
                      maxY = math.max(0.0, 56.0 - height);
                    } else {
                      if (page.showBottomNav) screenHeight -= 56;
                      if (page.showAppBar) minY = 40.0;
                      maxY = math.max(minY, screenHeight - height);
                    }
                    
                    final newY = (currentY + 1).clamp(minY, maxY);
                    context.read<BuilderBloc>().add(
                      UpdateElementLayoutEvent(activeElement.id, y: newY),
                    );
                  },
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 50,
              child: CustomTextField(
                text: tlVal,
                padding: EdgeInsets.zero,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  MinMaxIntValueFormatter(min: 0, max: 100),
                ],
                onChanged: (value) {
                  context.read<BuilderBloc>().add(
                    UpdatePropertyEvent(activeElement.id, 'radiusTopLeft', value),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 50,
              child: CustomTextField(
                text: trVal,
                padding: EdgeInsets.zero,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  MinMaxIntValueFormatter(min: 0, max: 100),
                ],
                onChanged: (value) {
                  context.read<BuilderBloc>().add(
                    UpdatePropertyEvent(activeElement.id, 'radiusTopRight', value),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 50,
              child: CustomTextField(
                text: blVal,
                padding: EdgeInsets.zero,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  MinMaxIntValueFormatter(min: 0, max: 100),
                ],
                onChanged: (value) {
                  context.read<BuilderBloc>().add(
                    UpdatePropertyEvent(activeElement.id, 'radiusBottomLeft', value),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 50,
              child: CustomTextField(
                text: brVal,
                padding: EdgeInsets.zero,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  MinMaxIntValueFormatter(min: 0, max: 100),
                ],
                onChanged: (value) {
                  context.read<BuilderBloc>().add(
                    UpdatePropertyEvent(activeElement.id, 'radiusBottomRight', value),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
