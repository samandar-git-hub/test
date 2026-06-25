import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/app_card.dart';
import '../../../common/widgets/app_dropdown.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../builder/presentation/bloc/builder_bloc.dart';
import '../../builder/presentation/bloc/builder_event.dart';
import '../../devices/data/models/device_model.dart';
import '../../devices/presentation/bloc/device_bloc.dart';
import '../../devices/presentation/bloc/device_event.dart';
import '../repo/projects_repository.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<ProjectItem> _projectsList = ProjectsRepository.myProjects;

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
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.projectsTab, style: context.style.s28w800),
          const SizedBox(height: 8),
          Text(context.l10n.projectsDesc, style: context.style.s14w400),
          const SizedBox(height: 32),
          Expanded(
            child: _projectsList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open_rounded, size: 64, color: colors.textMuted),
                        const SizedBox(height: 16),
                        Text(context.l10n.projectsEmpty, style: context.style.s16w600),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            // Go to Create route
                            context.go('/create');
                          },
                          child: Text(context.l10n.createProjectBtn),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.8,
                    ),
                    itemCount: _projectsList.length,
                    itemBuilder: (context, index) {
                      final project = _projectsList[index];
                      final isIphone = project.device == 'iPhone 17 Pro';

                      return AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: colors.violet.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    isIphone
                                        ? Icons.phone_iphone_rounded
                                        : Icons.phone_android_rounded,
                                    color: colors.violet,
                                    size: 18,
                                  ),
                                ),
                                const Spacer(),
                                AppDropdown<String>(
                                  tooltip: context.l10n.manage,
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      final devType = isIphone
                                          ? DeviceType.iphone17Pro
                                          : DeviceType.samsungS26;
                                      _launchBuilder(
                                        context,
                                        project.template,
                                        devType,
                                        project.name,
                                      );
                                    } else if (value == 'delete') {
                                      setState(() {
                                        _projectsList.removeAt(index);
                                      });
                                    }
                                  },
                                  items: [
                                    DropdownItem(
                                      value: 'edit',
                                      label: context.l10n.edit,
                                      icon: const Icon(Icons.edit_rounded, size: 16),
                                    ),
                                    DropdownItem(
                                      value: 'delete',
                                      label: context.l10n.delete,
                                      icon: const Icon(
                                        Icons.delete_rounded,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.more_vert_rounded,
                                      color: colors.textMuted,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(project.name, style: context.style.s15w600),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(project.date, style: context.style.s11w500),
                                Text(
                                  project.elements,
                                  style: context.style.s11w500.copyWith(color: colors.violet),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
