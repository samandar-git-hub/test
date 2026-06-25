import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/app_card.dart';
import '../../../common/widgets/app_dropdown.dart';
import '../../../core/theme/app_theme.dart';
import '../../devices/presentation/bloc/device_bloc.dart';
import '../../devices/presentation/bloc/device_event.dart';
import '../../devices/presentation/bloc/device_state.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.settingsTab, style: context.style.s28w800),
          const SizedBox(height: 8),
          Text(context.l10n.settingsDesc, style: context.style.s14w400),
          const SizedBox(height: 32),

          // Language Setting (UZ / EN)
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.langLabel, style: context.style.s15w600),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.langDesc,
                      style: context.style.s12w400.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    return AppDropdown<String>(
                      selectedValue: settingsState.languageCode,
                      onSelected: (lang) {
                        context.read<SettingsBloc>().add(ChangeLanguageEvent(lang));
                      },
                      items: const [
                        DropdownItem(value: 'uz', label: 'O\'zbekcha (UZ)'),
                        DropdownItem(value: 'en', label: 'English (EN)'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Theme setting
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.themeLabel, style: context.style.s15w600),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.themeDesc,
                      style: context.style.s12w400.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    return AppDropdown<ThemeMode>(
                      selectedValue: settingsState.themeMode,
                      onSelected: (mode) {
                        context.read<SettingsBloc>().add(SetThemeModeEvent(mode));
                      },
                      items: [
                        DropdownItem(value: ThemeMode.light, label: context.l10n.lightMode),
                        DropdownItem(value: ThemeMode.dark, label: context.l10n.darkMode),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Scale Factor setting
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.scaleLabel, style: context.style.s15w600),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.scaleDesc,
                      style: context.style.s12w400.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
                BlocBuilder<DeviceBloc, DeviceState>(
                  builder: (context, deviceState) {
                    return AppDropdown<double>(
                      selectedValue: deviceState.scaleFactor,
                      onSelected: (val) {
                        context.read<DeviceBloc>().add(SetScaleFactorEvent(val));
                      },
                      items: const [
                        DropdownItem(value: 0.70, label: '70%'),
                        DropdownItem(value: 0.85, label: '85%'),
                        DropdownItem(value: 1.00, label: '100%'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),

          // About Buildify signature
          Center(
            child: Column(
              children: [
                Text(
                  'Visual Buildify v1.2',
                  style: context.style.s12w600.copyWith(color: colors.textMuted),
                ),
                const SizedBox(height: 4),
                Text(context.l10n.createdBy, style: context.style.s11w500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
