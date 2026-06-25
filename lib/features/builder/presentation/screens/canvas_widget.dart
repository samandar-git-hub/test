import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../devices/data/models/device_model.dart';
import '../../../devices/presentation/bloc/device_bloc.dart';
import '../../../devices/presentation/screen/device_control_topbar.dart';
import '../../../devices/presentation/screen/iphone_17pro.dart';
import '../../../devices/presentation/screen/samsung_s26.dart';
import '../bloc/builder_bloc.dart';
import '../bloc/builder_event.dart';
import '../bloc/builder_state.dart';
import '../widgets/canvas/emulator_screen_body.dart';
import '../widgets/canvas/page_selector_bar.dart';

class CanvasWidget extends StatelessWidget {
  const CanvasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final builderBloc = context.read<BuilderBloc>();
    final deviceState = context.watch<DeviceBloc>().state;
    final colors = context.colors;

    final selectedDevice = deviceState.selectedDevice;
    final scale = deviceState.scaleFactor;
    final config = deviceConfigs[selectedDevice]!;

    // Calculate dynamic outer dimensions of the emulator frame
    final outerWidth = config.width + (config.bezelPadding * 2) + 2.5;
    final outerHeight = config.height + (config.bezelPadding * 2) + 2.5;

    // Determine which device frame to display
    Widget deviceFrame;
    if (selectedDevice == DeviceType.samsungS26) {
      deviceFrame = const SamsungS26(child: EmulatorScreenBody());
    } else {
      deviceFrame = const IPhone17Pro(child: EmulatorScreenBody());
    }

    return Expanded(
      child: KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: (event) {
          if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
            builderBloc.add(SetPendingElementEvent(null));
          }
        },
        child: GestureDetector(
          onTap: () {
            builderBloc.add(SelectElementEvent(null));
          },
          child: Container(
            color: colors.background,
            child: Column(
              children: [
                // --- Emulator Control Bar ---
                const DeviceControlTopbar(),

                // --- Page / Screen tabs ---
                const PageSelectorBar(),

                // --- Dynamic Placement Banner ---
                BlocBuilder<BuilderBloc, BuilderState>(
                  builder: (context, state) {
                    if (state.pendingPlacementType == null) {
                      return const SizedBox.shrink();
                    }

                    final typeName = state.pendingPlacementType!.displayName;

                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: colors.violet.withValues(alpha: 0.1),
                        border: Border(
                          bottom: BorderSide(color: colors.violet.withValues(alpha: 0.3), width: 1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const _PulsingDot(),
                          const SizedBox(width: 8),
                          Text(
                            'Joylashtirish rejimi: $typeName ni joylash uchun ekranning istalgan joyiga bosing',
                            style: context.style.s12w600.copyWith(color: colors.violet),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () {
                              context.read<BuilderBloc>().add(SetPendingElementEvent(null));
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              backgroundColor: colors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(color: colors.borderDark),
                              ),
                            ),
                            child: Text(
                              'Bekor qilish',
                              style: context.style.s11w600.copyWith(color: colors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // --- Screen Emulator Area ---
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Center(
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            child: SizedBox(
                              width: outerWidth * scale,
                              height: outerHeight * scale,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: outerWidth,
                                  height: outerHeight,
                                  child: deviceFrame,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.violet.withValues(alpha: 0.5 + _controller.value * 0.5),
            boxShadow: [
              BoxShadow(
                color: colors.violet.withValues(alpha: _controller.value * 0.4),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
