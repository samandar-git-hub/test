import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_buildify/common/text_fields/custom_text_field.dart';
import 'package:visual_buildify/common/utils/input_formatters.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';

import '../../../../../elements/models/builder_models.dart';
import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';

class SizeEditor extends StatelessWidget {
  final CanvasElement activeElement;

  const SizeEditor({super.key, required this.activeElement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.borderDark, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              text: activeElement.properties['width'] ?? '0',
              label: 'W:',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                MinMaxIntValueFormatter(min: 0, max: 1000),
              ],
              onChanged: (val) {
                final parsed = double.tryParse(val) ?? 0;
                context.read<BuilderBloc>().add(
                  UpdateElementLayoutEvent(activeElement.id, width: parsed),
                );
              },
            ),
          ),
          Expanded(
            child: CustomTextField(
              text: activeElement.properties['height'] ?? '0',
              label: 'H:',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                MinMaxIntValueFormatter(min: 0, max: 1000),
              ],
              onChanged: (val) {
                final parsed = double.tryParse(val) ?? 0;
                context.read<BuilderBloc>().add(
                  UpdateElementLayoutEvent(activeElement.id, height: parsed),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
