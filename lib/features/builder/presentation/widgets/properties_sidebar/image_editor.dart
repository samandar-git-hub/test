import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visual_buildify/common/buttons/custom_button.dart';
import 'package:visual_buildify/common/dropdown/custom_dropdown.dart';
import 'package:visual_buildify/common/text_fields/custom_text_field.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';
import 'package:visual_buildify/elements/models/builder_models.dart';

import '../../bloc/builder_bloc.dart';
import '../../bloc/builder_event.dart';

class ImageEditor extends StatelessWidget {
  final CanvasElement activeElement;

  const ImageEditor({super.key, required this.activeElement});

  Future<void> _pickImage(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: kIsWeb,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        String? src;

        if (kIsWeb) {
          if (file.bytes != null) {
            final base64String = base64Encode(file.bytes!);
            final extension = file.extension ?? 'png';
            src = 'data:image/$extension;base64,$base64String';
          }
        } else {
          src = file.path;
        }

        if (src != null && context.mounted) {
          context.read<BuilderBloc>().add(UpdatePropertyEvent(activeElement.id, 'src', src));
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final String srcVal = activeElement.properties['src'] ?? '';
    final String fitVal = activeElement.properties['fit'] ?? 'cover';

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
          CustomButton(
            onTap: () => _pickImage(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 6,
              children: [
                Text('Pick from Storage', style: TextStyle(color: context.colors.textMuted)),
                Text('Ctrl + V', style: TextStyle(color: context.colors.textMuted)),
              ],
            ),
          ),
          const Gap(8),
          CustomTextField(
            text: srcVal,
            label: 'Image URL:',
            onChanged: (val) {
              context.read<BuilderBloc>().add(UpdatePropertyEvent(activeElement.id, 'src', val));
            },
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: CustomDropDown<String>(
                  label: 'Box Fit:',
                  selectedValue: fitVal,
                  items: const [
                    CustomDropdownItem(value: 'cover', label: 'Cover'),
                    CustomDropdownItem(value: 'contain', label: 'Contain'),
                    CustomDropdownItem(value: 'fill', label: 'Fill'),
                    CustomDropdownItem(value: 'fitWidth', label: 'Fit Width'),
                    CustomDropdownItem(value: 'fitHeight', label: 'Fit Height'),
                    CustomDropdownItem(value: 'scaleDown', label: 'Scale Down'),
                    CustomDropdownItem(value: 'none', label: 'None'),
                  ],
                  onSelected: (value) {
                    context.read<BuilderBloc>().add(
                      UpdatePropertyEvent(activeElement.id, 'fit', value),
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
