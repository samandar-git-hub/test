import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class DashboardShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: Row(
        children: [
          // Sidebar Panel
          _buildSidebar(context, colors),

          // Router Branch Viewport
          Expanded(child: navigationShell),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, AppColors colors) {
    final currentIndex = navigationShell.currentIndex;

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: Border(right: BorderSide(color: colors.borderDark, width: 1)),
      ),
      child: Column(
        children: [
          // Logo & Branding
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [colors.violet, colors.blue]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.gesture_rounded, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  context.l10n.appName,
                  style: context.style.s20w700.copyWith(color: context.colors.textPrimary),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.borderDark),
          const SizedBox(height: 16),

          // Sidebar Navigation Items mapping to GoRouter Branch Indices
          _SidebarItem(
            icon: Icons.dashboard_outlined,
            activeIcon: Icons.dashboard_rounded,
            label: context.l10n.homeTab,
            isActive: currentIndex == 0,
            onTap: () => navigationShell.goBranch(0),
          ),
          _SidebarItem(
            icon: Icons.add_circle_outline_rounded,
            activeIcon: Icons.add_circle_rounded,
            label: context.l10n.createTab,
            isActive: currentIndex == 1,
            onTap: () => navigationShell.goBranch(1),
          ),
          _SidebarItem(
            icon: Icons.folder_open_outlined,
            activeIcon: Icons.folder_rounded,
            label: context.l10n.projectsTab,
            isActive: currentIndex == 2,
            onTap: () => navigationShell.goBranch(2),
          ),
          _SidebarItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings_rounded,
            label: context.l10n.settingsTab,
            isActive: currentIndex == 3,
            onTap: () => navigationShell.goBranch(3),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final activeColor = colors.violet;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? activeColor.withValues(alpha: 0.1)
                  : _isHovered
                  ? colors.surface
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isActive ? activeColor.withValues(alpha: 0.2) : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  widget.isActive ? widget.activeIcon : widget.icon,
                  color: widget.isActive ? activeColor : colors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.label,
                  style: (widget.isActive ? context.style.s14w600 : context.style.s14w500).copyWith(
                    color: widget.isActive ? colors.textPrimary : colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
