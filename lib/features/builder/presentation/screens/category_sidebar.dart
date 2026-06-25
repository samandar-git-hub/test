import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../settings/bloc/settings_bloc.dart';
import '../../../settings/bloc/settings_event.dart';
import '../../../settings/bloc/settings_state.dart';
import '../bloc/builder_bloc.dart';
import '../bloc/builder_event.dart';
import '../widgets/sidebar/category_button.dart';

class CategorySidebar extends StatelessWidget {
  const CategorySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final activeCategory = context.select<BuilderBloc, String>(
      (bloc) => bloc.state.selectedCategory,
    );
    final colors = context.colors;

    final List<CategoryItem> categories = [
      CategoryItem(id: 'Barchasi', label: 'Barchasi', icon: Icons.grid_view_rounded),
      CategoryItem(id: 'Matnlar', label: 'Matnlar', icon: Icons.text_fields_rounded),
      CategoryItem(id: 'Tugmalar', label: 'Tugmalar', icon: Icons.smart_button_rounded),
      CategoryItem(id: 'Dizayn', label: 'Dizayn', icon: Icons.dashboard_customize_rounded),
      CategoryItem(id: 'Tayyor bloklar', label: 'Bloklar', icon: Icons.widgets_rounded),
    ];

    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(right: BorderSide(color: colors.borderDark, width: 1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.violet, colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: colors.violet.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: colors.borderDark),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isActive = category.id == activeCategory;

                return CategoryButton(
                  item: category,
                  isActive: isActive,
                  onTap: () => context.read<BuilderBloc>().add(SelectCategoryEvent(category.id)),
                );
              },
            ),
          ),
          Divider(height: 1, color: colors.borderDark),
          const Gap(10),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              final isDark = settingsState.isDark;
              return GestureDetector(
                onTap: () => context.read<SettingsBloc>().add(const ToggleThemeEvent()),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 24),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.borderDark, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AnimatedRotation(
                    turns: isDark ? 0.0 : 0.5,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isDark ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
                      color: isDark ? Colors.amber[400] : colors.violet,
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
