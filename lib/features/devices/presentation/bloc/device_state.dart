import '../../data/models/device_model.dart';

class DeviceState {
  final DeviceType selectedDevice;
  final double scaleFactor;

  DeviceState({
    required this.selectedDevice,
    required this.scaleFactor,
  });

  DeviceState copyWith({
    DeviceType? selectedDevice,
    double? scaleFactor,
  }) {
    return DeviceState(
      selectedDevice: selectedDevice ?? this.selectedDevice,
      scaleFactor: scaleFactor ?? this.scaleFactor,
    );
  }
}
