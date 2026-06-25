import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/app_button.dart';
import '../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  colors.violet.withValues(alpha: 0.15),
                  colors.blue.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: colors.violet.withValues(alpha: 0.2), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.violet.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.violet.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    'Visual Buildify v1.2',
                    style: context.style.s11w600.copyWith(color: colors.violet),
                  ),
                ),
                const SizedBox(height: 16),
                Text(context.l10n.welcomeTitle, style: context.style.s32w800),
                const SizedBox(height: 12),
                Text(context.l10n.welcomeDesc, style: context.style.s14w400),
                const SizedBox(height: 24),
                AppButton(
                  label: context.l10n.createProjectBtn,
                  icon: Icons.add_circle_outline_rounded,
                  backgroundColor: colors.violet,
                  textColor: Colors.white,
                  width: 250,
                  onPressed: () {
                    context.go('/create');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
