import 'package:flutter/material.dart';
import '../localization/generated/app_localizations.dart';
import '../theme/app_theme.dart';

extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  AppStyles get style => AppStyles(colors);
}
