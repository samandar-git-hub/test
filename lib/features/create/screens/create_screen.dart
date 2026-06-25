import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../builder/presentation/bloc/builder_bloc.dart';
import '../../builder/presentation/bloc/builder_event.dart';
import '../../devices/data/models/device_model.dart';
import '../../devices/presentation/bloc/device_bloc.dart';
import '../../devices/presentation/bloc/device_event.dart';
import '../../projects/repo/projects_repository.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _projectNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_projectNameController.text.isEmpty) {
      _projectNameController.text = context.l10n.projectNameHint;
    }
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

  void _launchBuilder(BuildContext context, String template, DeviceType deviceType, String name) {
    // 1. Set device in DeviceBloc
    context.read<DeviceBloc>().add(SetDeviceEvent(deviceType));

    // 2. Load template in BuilderBloc
    context.read<BuilderBloc>().add(LoadTemplateProjectEvent(template));

    // 3. Open Builder screen
    context.push(AppRoutes.builder);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.createProjectBtn, style: context.style.s28w800),
          const SizedBox(height: 8),
          Text(context.l10n.createWizardDesc, style: context.style.s14w400),
          const SizedBox(height: 32),

          // Project Name input
          Text(context.l10n.projectNameLabel, style: context.style.s14w600),
          const SizedBox(height: 8),
          AppTextField(
            controller: _projectNameController,
            hintText: context.l10n.projectNameHint,
            width: 500,
          ),
          const SizedBox(height: 48),

          // Create Button
          AppButton(
            label: context.l10n.startProjectBtn,
            icon: Icons.arrow_forward_rounded,
            width: 320,
            height: 56,
            isGradient: true,
            onPressed: () {
              final name = _projectNameController.text.trim();
              final finalName = name.isEmpty ? context.l10n.createTab : name;

              // Save to projects repository
              final newProject = ProjectItem(
                id: 'proj_${DateTime.now().millisecondsSinceEpoch}',
                name: finalName,
                template: 'blank',
                device: 'iPhone 17 Pro',
                date: context.l10n.justNow,
                elements: '0 ${context.l10n.elementsCount}',
              );

              ProjectsRepository.myProjects.insert(0, newProject);

              // Launch builder with a blank template and iPhone 17 Pro device config
              _launchBuilder(context, 'blank', DeviceType.iphone17Pro, finalName);
            },
          ),
        ],
      ),
    );
  }
}
