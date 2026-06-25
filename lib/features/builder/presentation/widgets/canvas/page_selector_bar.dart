import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/app_control_button.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../elements/models/builder_models.dart';
import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';

class PageSelectorBar extends StatelessWidget {
  const PageSelectorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final builderBloc = context.read<BuilderBloc>();
    final pages = context.select<BuilderBloc, List<BuilderPage>>((bloc) => bloc.state.pages);
    final activePageId = context.select<BuilderBloc, String?>((bloc) => bloc.state.activePageId);
    final colors = context.colors;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: Border(bottom: BorderSide(color: colors.borderDark, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: pages.map((page) {
                  final isSelected = page.id == activePageId;
                  return GestureDetector(
                    onTap: () => builderBloc.add(SelectPageEvent(page.id)),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.violet.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? colors.violet : Colors.transparent),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.layers,
                            size: 14,
                            color: isSelected ? colors.violet : colors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            page.name,
                            style: (isSelected ? context.style.s12w600 : context.style.s12w500)
                                .copyWith(color: isSelected ? colors.violet : colors.textSecondary),
                          ),
                          if (pages.length > 1) ...[
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                builderBloc.add(DeletePageEvent(page.id));
                              },
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: isSelected
                                    ? colors.violet.withValues(alpha: 0.6)
                                    : colors.textMuted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          AppControlButton(
            icon: Icons.add,
            tooltip: context.l10n.addNewPageTooltip,
            onPressed: () {
              builderBloc.add(AddPageEvent('${context.l10n.pageDefaultName} ${pages.length + 1}'));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
