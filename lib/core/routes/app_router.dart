import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/builder/presentation/screens/builder_screen.dart';
import '../../features/create/screens/create_screen.dart';
import '../../features/dashboard/screens/dashboard_shell.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/projects/screens/projects_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _createNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _projectsNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _settingsNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      /// ===========================================================
      ///             TAB ROUTES
      /// ===========================================================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _createNavigatorKey,
            routes: [
              GoRoute(path: AppRoutes.create, builder: (context, state) => const CreateScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _projectsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.projects,
                builder: (context, state) => const ProjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),

      /// ===========================================================
      ///             NON-TAB ROUTES
      /// ===========================================================

      /// Builder Route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.builder,
        builder: (context, state) => const BuilderScreen(),
      ),
    ],
  );
}
