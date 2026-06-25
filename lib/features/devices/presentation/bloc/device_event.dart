import '../../data/models/device_model.dart';

abstract class DeviceEvent {}

class SetDeviceEvent extends DeviceEvent {
  final DeviceType device;
  SetDeviceEvent(this.device);
}

class SetScaleFactorEvent extends DeviceEvent {
  final double scaleFactor;
  SetScaleFactorEvent(this.scaleFactor);
}
