import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../devices/data/models/device_model.dart';
import '../../../../devices/presentation/bloc/device_bloc.dart';
import '../../../../../elements/models/builder_models.dart';
import '../../../../../elements/templates/element_templates.dart';
import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';
import '../../bloc/builder_state.dart';
import 'empty_state.dart';
import 'grid_painter.dart';
import 'selectable_element.dart';

class CanvasContent extends StatelessWidget {
  const CanvasContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<BuilderBloc, BuilderState>(
      builder: (context, state) {
        final bodyElements = state.elements.where((el) {
          final area = el.properties['area'];
          return area == null || area == 'body';
        }).toList();

        final orderedElements = List<CanvasElement>.from(bodyElements);
        if (state.activeElementId != null) {
          final activeIndex = orderedElements.indexWhere((e) => e.id == state.activeElementId);
          if (activeIndex != -1) {
            final activeElement = orderedElements.removeAt(activeIndex);
            orderedElements.add(activeElement);
          }
        }

        Widget content = bodyElements.isEmpty
            ? const EmptyState()
            : SizedBox.expand(
                child: IgnorePointer(
                  ignoring: state.pendingPlacementType != null,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: orderedElements.map((element) {
                      final isActive = element.id == state.activeElementId;
                      return SelectableElement(
                        key: ValueKey(element.id),
                        element: element,
                        isActive: isActive,
                        index: 0,
                        totalCount: bodyElements.length,
                        onSelect: () {
                          context.read<BuilderBloc>().add(
                            SelectElementEvent(isActive ? null : element.id),
                          );
                        },
                        onDelete: () =>
                            context.read<BuilderBloc>().add(RemoveElementEvent(element.id)),
                        onMoveUp: () =>
                            context.read<BuilderBloc>().add(MoveElementUpEvent(element.id)),
                        onMoveDown: () =>
                            context.read<BuilderBloc>().add(MoveElementDownEvent(element.id)),
                      );
                    }).toList(),
                  ),
                ),
              );

        Widget mainWidget = content;
        if (state.showGrid) {
          mainWidget = Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: GridPainter(gridColor: colors.borderMedium, gridSpacing: 8),
                  ),
                ),
              ),
              content,
            ],
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (details) {
            final pendingType = state.pendingPlacementType;
            if (pendingType != null) {
              final template = getTemplateByType(pendingType);
              final double width = double.tryParse(template.defaultProperties['width'] ?? '200') ?? 200.0;
              final double height = double.tryParse(template.defaultProperties['height'] ?? '80') ?? 80.0;

              final deviceState = context.read<DeviceBloc>().state;
              final config = deviceConfigs[deviceState.selectedDevice]!;
              final double screenWidth = config.width;
              double screenHeight = config.height - config.statusBarHeight;

              final page = state.activePage;

              double centerX = details.localPosition.dx - (width / 2);
              double centerY = details.localPosition.dy - (height / 2);

              double minY = 0.0;
              if (page.showAppBar) {
                minY = 40.0;
              }
              if (page.showBottomNav) {
                screenHeight -= 56;
              }

              centerX = centerX.clamp(0.0, math.max(0.0, screenWidth - width));
              centerY = centerY.clamp(minY, math.max(minY, screenHeight - height));

              context.read<BuilderBloc>().add(
                AddElementEvent(
                  pendingType,
                  area: 'body',
                  x: centerX,
                  y: centerY,
                ),
              );
            }
          },
          child: mainWidget,
        );
      },
    );
  }
}
