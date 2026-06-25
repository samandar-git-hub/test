import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';

import '../../../../elements/elements.dart';
import '../bloc/builder_bloc.dart';
import '../bloc/builder_event.dart';
import '../bloc/builder_state.dart';
import '../widgets/sidebar/component_button.dart';

class ComponentsSidebar extends StatelessWidget {
  const ComponentsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final builderBloc = context.read<BuilderBloc>();
    final selectedCategory = context.select<BuilderBloc, String>(
      (bloc) => bloc.state.selectedCategory,
    );
    final colors = context.colors;

    final filteredTemplates = elementTemplates.where((template) {
      if (selectedCategory == 'Barchasi') return true;
      return template.category == selectedCategory;
    }).toList();

    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: Border(right: BorderSide(color: colors.borderDark, width: 1)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                '${context.l10n.componentsTitle} - ${selectedCategory.toUpperCase()}',
                style: context.style.s11w600.copyWith(letterSpacing: 1.5),
              ),
            ),
            if (filteredTemplates.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.l10n.noComponentsInCategory,
                  style: context.style.s13w500.copyWith(color: colors.textMuted),
                ),
              )
            else
              ...filteredTemplates.map(
                (template) => BlocBuilder<BuilderBloc, BuilderState>(
                  builder: (context, state) {
                    final isSelected = state.pendingPlacementType == template.type;
                    return ComponentButton(
                      template: template,
                      isSelected: isSelected,
                      onTap: () {
                        if (isSelected) {
                          builderBloc.add(SetPendingElementEvent(null));
                        } else {
                          builderBloc.add(SetPendingElementEvent(template.type));
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
