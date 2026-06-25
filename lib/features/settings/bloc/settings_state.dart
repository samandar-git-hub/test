import 'package:flutter/material.dart';

class SettingsState {
  final ThemeMode themeMode;
  final String languageCode;

  const SettingsState({
    required this.themeMode,
    required this.languageCode,
  });

  bool get isDark => themeMode == ThemeMode.dark;
  bool get isUz => languageCode == 'uz';
  bool get isEn => languageCode == 'en';

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? languageCode,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
