import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../elements/canvas_element_renderer.dart';
import '../../../../../elements/models/builder_models.dart';
import '../../../../devices/data/models/device_model.dart';
import '../../../../devices/presentation/bloc/device_bloc.dart';
import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';

class SelectableElement extends StatelessWidget {
  final CanvasElement element;
  final bool isActive;
  final int index;
  final int totalCount;
  final VoidCallback onSelect;
  final VoidCallback onDelete;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const SelectableElement({
    super.key,
    required this.element,
    required this.isActive,
    required this.index,
    required this.totalCount,
    required this.onSelect,
    required this.onDelete,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final p = element.properties;
    final double x = double.tryParse(p['x'] ?? '40') ?? 40.0;
    final double y = double.tryParse(p['y'] ?? '100') ?? 100.0;
    final double width = double.tryParse(p['width'] ?? '200') ?? 200.0;
    final double height = double.tryParse(p['height'] ?? '80') ?? 80.0;

    return Positioned(
      left: x,
      top: y,
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onSelect,
        onPanUpdate: (details) {
          final deviceState = context.read<DeviceBloc>().state;
          final config = deviceConfigs[deviceState.selectedDevice]!;
          final double screenWidth = config.width;
          double screenHeight = config.height - config.statusBarHeight;

          final page = context.read<BuilderBloc>().state.activePage;
          final double scale = deviceState.scaleFactor;

          final area = element.properties['area'];

          double minX = 0.0;
          double maxX = math.max(0.0, screenWidth - width);
          double minY = 0.0;
          double maxY = 0.0;

          if (area == 'appBar') {
            maxY = math.max(0.0, 40.0 - height);
          } else if (area == 'bottomNav') {
            maxY = math.max(0.0, 56.0 - height);
          } else {
            if (page.showBottomNav) {
              screenHeight -= 56;
            }
            if (page.showAppBar) {
              minY = 40.0;
            }
            maxY = math.max(minY, screenHeight - height);
          }

          final double newX = (x + details.delta.dx / scale).clamp(minX, maxX);
          final double newY = (y + details.delta.dy / scale).clamp(minY, maxY);

          context.read<BuilderBloc>().add(UpdateElementLayoutEvent(element.id, x: newX, y: newY));
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(border: Border.all(color: colors.violet, width: 1.5))
                  : null,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CanvasElementRenderer(element: element),
              ),
            ),

            if (isActive) ...[
              Positioned(top: -3, left: -3, child: _buildCornerDot(colors)),
              Positioned(top: -3, right: -3, child: _buildCornerDot(colors)),
              Positioned(bottom: -3, left: -3, child: _buildCornerDot(colors)),
              Positioned(bottom: -3, right: -3, child: _buildCornerDot(colors)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCornerDot(AppColors colors) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colors.violet, width: 1.5),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
