import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visual_buildify/common/dropdown/color_dropdown.dart';
import 'package:visual_buildify/common/dropdown/color_picker_dropdown.dart';
import 'package:visual_buildify/common/dropdown/custom_dropdown.dart';
import 'package:visual_buildify/common/text_fields/custom_text_field.dart';
import 'package:visual_buildify/common/utils/dropdown_colors.dart';
import 'package:visual_buildify/common/utils/font_weights.dart';
import 'package:visual_buildify/common/utils/input_formatters.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';
import 'package:visual_buildify/elements/models/builder_models.dart';

import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';

class TextEditor extends StatelessWidget {
  final CanvasElement activeElement;

  const TextEditor({super.key, required this.activeElement});

  @override
  Widget build(BuildContext context) {
    final String textVal = activeElement.properties['text'] ?? 'Text';
    final String fontSizeVal = activeElement.properties['fontSize'] ?? '14';
    final String fontWeightVal = activeElement.properties['fontWeight'] ?? 'normal';
    final String textColorVal = activeElement.properties['textColor'] ?? '#111827';

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.borderDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            text: textVal,
            label: 'Text:',
            onChanged: (val) {
              context.read<BuilderBloc>().add(UpdatePropertyEvent(activeElement.id, 'text', val));
            },
          ),
          const Gap(8),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'Size:',
                  text: fontSizeVal,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    MinMaxIntValueFormatter(min: 0, max: 100),
                  ],
                  onChanged: (val) {
                    context.read<BuilderBloc>().add(
                      UpdatePropertyEvent(activeElement.id, 'fontSize', val),
                    );
                  },
                ),
              ),
              Expanded(
                child: CustomDropDown(
                  label: 'Weight:',
                  selectedValue: fontWeightVal,
                  items: AppFontWeights.items,
                  onSelected: (value) {
                    context.read<BuilderBloc>().add(
                      UpdatePropertyEvent(activeElement.id, 'fontWeight', value),
                    );
                  },
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: ColorPickerDropdown(
                  label: 'Custom:',
                  selectedValue: textColorVal,
                  onSelected: (value) {
                    context.read<BuilderBloc>().add(
                      UpdatePropertyEvent(activeElement.id, 'textColor', value),
                    );
                  },
                ),
              ),
              Expanded(
                child: ColorDropDown(
                  label: 'Color:',
                  selectedValue: textColorVal,
                  items: DropdownColors.items,
                  onSelected: (val) {
                    context.read<BuilderBloc>().add(
                      UpdatePropertyEvent(activeElement.id, 'textColor', val),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
