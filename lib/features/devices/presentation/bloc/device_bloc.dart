import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/device_model.dart';
import 'device_event.dart';
import 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(DeviceState(selectedDevice: DeviceType.iphone17Pro, scaleFactor: 0.85)) {
    on<SetDeviceEvent>((event, emit) {
      emit(state.copyWith(selectedDevice: event.device));
    });

    on<SetScaleFactorEvent>((event, emit) {
      emit(state.copyWith(scaleFactor: event.scaleFactor));
    });
  }
}
