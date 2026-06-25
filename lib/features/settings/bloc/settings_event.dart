import 'package:flutter/material.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class ToggleThemeEvent extends SettingsEvent {
  const ToggleThemeEvent();
}

class SetThemeModeEvent extends SettingsEvent {
  final ThemeMode themeMode;
  const SetThemeModeEvent(this.themeMode);
}

class ChangeLanguageEvent extends SettingsEvent {
  final String languageCode;
  const ChangeLanguageEvent(this.languageCode);
}
