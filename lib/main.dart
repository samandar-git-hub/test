import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/localization/generated/app_localizations.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/builder/presentation/bloc/builder_bloc.dart';
import 'features/devices/presentation/bloc/device_bloc.dart';
import 'features/settings/bloc/settings_bloc.dart';
import 'features/settings/bloc/settings_state.dart';

void main() {
  runApp(const VisualBuildifyApp());
}

class VisualBuildifyApp extends StatelessWidget {
  const VisualBuildifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => BuilderBloc()),
        BlocProvider(create: (_) => DeviceBloc()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp.router(
            title: 'Visual Buildify',
            debugShowCheckedModeBanner: false,
            themeMode: settingsState.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(settingsState.languageCode),
          );
        },
      ),
    );
  }
}
