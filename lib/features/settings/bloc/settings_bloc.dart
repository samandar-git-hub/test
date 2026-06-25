import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(const SettingsState(
          themeMode: ThemeMode.dark,
          languageCode: 'uz',
        )) {
    on<ToggleThemeEvent>((event, emit) {
      final newMode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      emit(state.copyWith(themeMode: newMode));
    });

    on<SetThemeModeEvent>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<ChangeLanguageEvent>((event, emit) {
      if (state.languageCode == event.languageCode) return;
      emit(state.copyWith(languageCode: event.languageCode));
    });
  }
}
