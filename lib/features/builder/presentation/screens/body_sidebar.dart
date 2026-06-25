import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visual_buildify/common/dropdown/custom_dropdown.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';

import '../../../../elements/models/builder_models.dart';
import '../bloc/builder_bloc.dart';
import '../bloc/builder_event.dart';
import '../widgets/properties_sidebar/image_editor.dart';
import '../widgets/properties_sidebar/position_radius_editor.dart';
import '../widgets/properties_sidebar/property_inputs.dart';
import '../widgets/properties_sidebar/size_editor.dart';
import '../widgets/properties_sidebar/text_editor.dart';
import 'scaffold_sidebar.dart';

class BodySidebar extends StatelessWidget {
  const BodySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final activeElement = context.select<BuilderBloc, CanvasElement?>(
      (bloc) => bloc.state.activeElement,
    );

    if (activeElement == null) {
      return const ScaffoldSidebar();
    }

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: context.colors.sidebar,
        border: Border(left: BorderSide(color: context.colors.borderDark, width: 1)),
      ),
      child: Column(
        children: [
          // --- Footer ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: context.colors.borderDark, width: 1)),
            ),
            child: Row(
              children: [
                DeleteButton(
                  onTap: () =>
                      context.read<BuilderBloc>().add(RemoveElementEvent(activeElement.id)),
                ),
                const Gap(16),
                DuplicateButton(
                  onTap: () =>
                      context.read<BuilderBloc>().add(DuplicateElementEvent(activeElement.id)),
                ),
              ],
            ),
          ),

          /// ============================================
          ///  PROPERTIES LIST
          /// ============================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.positionAndSizeHeader, style: context.style.s10w600),
                  const Gap(16),
                  PositionRadiusEditor(activeElement: activeElement),
                  const Gap(16),
                  if (!activeElement.id.contains('appbar_title') && !activeElement.id.contains('bottom_nav_item')) ...[
                    Text('JOYLASHUV SOHASI', style: context.style.s10w600),
                    const Gap(12),
                    CustomDropDown<String>(
                      label: 'Soha:',
                      selectedValue: activeElement.properties['area'] ?? 'body',
                      items: const [
                        CustomDropdownItem(value: 'body', label: 'Body'),
                        CustomDropdownItem(value: 'appBar', label: 'AppBar'),
                        CustomDropdownItem(value: 'bottomNav', label: 'Bottom Bar'),
                      ],
                      onSelected: (value) {
                        context.read<BuilderBloc>().add(
                          UpdatePropertyEvent(activeElement.id, 'area', value),
                        );
                        context.read<BuilderBloc>().add(
                          UpdateElementLayoutEvent(activeElement.id, x: 0, y: 0),
                        );
                      },
                    ),
                    const Gap(16),
                  ],
                  SizeEditor(activeElement: activeElement),
                  const Gap(16),
                  TextEditor(activeElement: activeElement),
                  const Gap(16),
                  ImageEditor(activeElement: activeElement),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
