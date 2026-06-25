import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_buildify/features/builder/presentation/widgets/canvas/canvas_content.dart';

import '../../../../../core/utils/helpers.dart';
import '../../../../../elements/models/builder_models.dart';
import '../../../../../elements/templates/element_templates.dart';
import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';
import '../../bloc/builder_state.dart';
import 'selectable_element.dart';

class EmulatorScreenBody extends StatelessWidget {
  const EmulatorScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final page = context.select<BuilderBloc, BuilderPage>((bloc) => bloc.state.activePage);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double totalHeight = constraints.maxHeight;

        return BlocBuilder<BuilderBloc, BuilderState>(
          builder: (context, state) {
            final pendingType = state.pendingPlacementType;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                if (pendingType != null) {
                  final template = getTemplateByType(pendingType);
                  final double width =
                      double.tryParse(template.defaultProperties['width'] ?? '200') ?? 200.0;
                  final double height =
                      double.tryParse(template.defaultProperties['height'] ?? '80') ?? 80.0;

                  final double appBarHeight = 40.0;
                  final double bottomNavHeight = 56.0;

                  String targetArea = 'body';
                  double localX = details.localPosition.dx;
                  double localY = details.localPosition.dy;

                  if (page.showAppBar && localY < appBarHeight) {
                    targetArea = 'appBar';
                  } else if (page.showBottomNav && localY > (totalHeight - bottomNavHeight)) {
                    targetArea = 'bottomNav';
                    localY = localY - (totalHeight - bottomNavHeight);
                  } else {
                    targetArea = 'body';
                  }

                  double centerX = localX - (width / 2);
                  double centerY = localY - (height / 2);

                  if (targetArea == 'appBar') {
                    centerX = centerX.clamp(0.0, math.max(0.0, totalWidth - width));
                    centerY = centerY.clamp(0.0, math.max(0.0, appBarHeight - height));
                  } else if (targetArea == 'bottomNav') {
                    centerX = centerX.clamp(0.0, math.max(0.0, totalWidth - width));
                    centerY = centerY.clamp(0.0, math.max(0.0, bottomNavHeight - height));
                  } else {
                    centerX = centerX.clamp(0.0, math.max(0.0, totalWidth - width));
                    double minY = 0.0;
                    double maxY = totalHeight;
                    if (page.showAppBar) {
                      minY = appBarHeight;
                    }
                    if (page.showBottomNav) {
                      maxY -= bottomNavHeight;
                    }
                    centerY = centerY.clamp(minY, math.max(minY, maxY - height));
                  }

                  context.read<BuilderBloc>().add(
                    AddElementEvent(pendingType, area: targetArea, x: centerX, y: centerY),
                  );
                }
              },
              child: Stack(
                children: [
                  IgnorePointer(
                    ignoring: pendingType != null,
                    child: const CanvasContent(),
                  ),
                  if (page.showAppBar)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        ignoring: pendingType != null,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          color: parseHexColor(page.appBarBgColor),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: state.elements
                                .where((el) => el.properties['area'] == 'appBar')
                                .map((element) {
                                  final isActive = element.id == state.activeElementId;
                                  return SelectableElement(
                                    key: ValueKey(element.id),
                                    element: element,
                                    isActive: isActive,
                                    index: 0,
                                    totalCount: state.elements
                                        .where((el) => el.properties['area'] == 'appBar')
                                        .length,
                                    onSelect: () {
                                      context.read<BuilderBloc>().add(
                                        SelectElementEvent(isActive ? null : element.id),
                                      );
                                    },
                                    onDelete: () => context.read<BuilderBloc>().add(
                                      RemoveElementEvent(element.id),
                                    ),
                                    onMoveUp: () => context.read<BuilderBloc>().add(
                                      MoveElementUpEvent(element.id),
                                    ),
                                    onMoveDown: () => context.read<BuilderBloc>().add(
                                      MoveElementDownEvent(element.id),
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  if (page.showBottomNav)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: IgnorePointer(
                        ignoring: pendingType != null,
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          color: parseHexColor(page.bottomNavBgColor),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: state.elements
                                .where((el) => el.properties['area'] == 'bottomNav')
                                .map((element) {
                                  final isActive = element.id == state.activeElementId;
                                  return SelectableElement(
                                    key: ValueKey(element.id),
                                    element: element,
                                    isActive: isActive,
                                    index: 0,
                                    totalCount: state.elements
                                        .where((el) => el.properties['area'] == 'bottomNav')
                                        .length,
                                    onSelect: () {
                                      context.read<BuilderBloc>().add(
                                        SelectElementEvent(isActive ? null : element.id),
                                      );
                                    },
                                    onDelete: () => context.read<BuilderBloc>().add(
                                      RemoveElementEvent(element.id),
                                    ),
                                    onMoveUp: () => context.read<BuilderBloc>().add(
                                      MoveElementUpEvent(element.id),
                                    ),
                                    onMoveDown: () => context.read<BuilderBloc>().add(
                                      MoveElementDownEvent(element.id),
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
