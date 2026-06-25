import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFEDE9FE), Color(0xFFDBEAFE)],
                ),
              ),
              child: Center(
                child: Icon(Icons.add_box_outlined, size: 32, color: colors.violetDark),
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back, size: 16, color: colors.violet),
                const SizedBox(width: 8),
                Text(
                  context.l10n.startFromLeftPanel,
                  style: context.style.s14w500.copyWith(color: colors.violet),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
