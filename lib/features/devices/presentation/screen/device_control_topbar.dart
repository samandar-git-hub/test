import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/app_control_button.dart';
import '../../../../common/widgets/app_dropdown.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../builder/presentation/bloc/builder_bloc.dart';
import '../../../builder/presentation/bloc/builder_event.dart';
import '../../data/models/device_model.dart';
import '../bloc/device_bloc.dart';
import '../bloc/device_event.dart';

class DeviceControlTopbar extends StatelessWidget {
  const DeviceControlTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceState = context.watch<DeviceBloc>().state;
    final builderState = context.watch<BuilderBloc>().state;
    final selectedDevice = deviceState.selectedDevice;
    final scale = deviceState.scaleFactor;
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: Border(bottom: BorderSide(color: colors.borderDark, width: 1)),
      ),
      child: Row(
        children: [
          AppDropdown<DeviceType>(
            selectedValue: selectedDevice,
            onSelected: (type) => context.read<DeviceBloc>().add(SetDeviceEvent(type)),
            items: DeviceType.values.map((type) {
              final dev = deviceConfigs[type]!;
              return DropdownItem<DeviceType>(
                value: type,
                label: dev.name,
                icon: Text(dev.icon, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
          ),

          AppControlButton(
            icon: builderState.showGrid ? Icons.grid_on : Icons.grid_off,
            onPressed: () => context.read<BuilderBloc>().add(ToggleGridEvent()),
            tooltip: context.l10n.gridToggle,
            isActive: builderState.showGrid,
          ),

          AppControlButton(
            icon: Icons.zoom_out,
            onPressed: scale > 0.4
                ? () => context.read<DeviceBloc>().add(SetScaleFactorEvent(scale - 0.05))
                : null,
          ),
          const SizedBox(width: 8),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Text('${(scale * 100).round()}%', style: context.style.s13w600),
          ),
          const SizedBox(width: 8),
          AppControlButton(
            icon: Icons.zoom_in,
            onPressed: scale < 1.5
                ? () => context.read<DeviceBloc>().add(SetScaleFactorEvent(scale + 0.05))
                : null,
          ),
        ],
      ),
    );
  }
}
