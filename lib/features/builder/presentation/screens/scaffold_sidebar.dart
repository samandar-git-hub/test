import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_buildify/common/dropdown/color_dropdown.dart';
import 'package:visual_buildify/common/dropdown/color_picker_dropdown.dart';
import 'package:visual_buildify/common/utils/dropdown_colors.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../elements/models/builder_models.dart';
import '../bloc/builder_bloc.dart';
import '../bloc/builder_event.dart';
import '../widgets/properties_sidebar/property_inputs.dart';

class ScaffoldSidebar extends StatelessWidget {
  const ScaffoldSidebar({super.key});

 

  @override
  Widget build(BuildContext context) {
    final page = context.select<BuilderBloc, BuilderPage>((bloc) => bloc.state.activePage);

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: context.colors.sidebar,
        border: Border(left: BorderSide(color: context.colors.borderDark, width: 1)),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.pageNameLabelUppercase,
                  style: context.style.s11w600.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(height: 8),
                TextPropertyInput(
                  value: page.name,
                  placeholder: context.l10n.pageNamePlaceholder,
                  onChanged: (val) {
                    context.read<BuilderBloc>().add(RenamePageEvent(page.id, val));
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.addAppBarLabel,
                      style: context.style.s11w600.copyWith(letterSpacing: 1.5),
                    ),
                    Switch(
                      value: page.showAppBar,
                      activeThumbColor: context.colors.violet,
                      onChanged: (val) {
                        context.read<BuilderBloc>().add(UpdatePageSettingsEvent(showAppBar: val));
                      },
                    ),
                  ],
                ),

                if (page.showAppBar) ...[
                  const SizedBox(height: 12),
                  Text(context.l10n.appBarTitleLabel, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  TextPropertyInput(
                    value: page.appBarTitle,
                    placeholder: context.l10n.titleTextPlaceholder,
                    onChanged: (val) {
                      context.read<BuilderBloc>().add(UpdatePageSettingsEvent(appBarTitle: val));
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(context.l10n.bgColorLabel, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ColorPickerDropdown(
                          label: 'Custom:',
                          selectedValue: page.appBarBgColor,
                          onSelected: (value) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(appBarBgColor: value),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ColorDropDown(
                          label: 'Color:',
                          selectedValue: page.appBarBgColor,
                          items: DropdownColors.items,
                          onSelected: (val) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(appBarBgColor: val),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(context.l10n.textColorLabel, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ColorPickerDropdown(
                          label: 'Custom:',
                          selectedValue: page.appBarTextColor,
                          onSelected: (value) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(appBarTextColor: value),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ColorDropDown(
                          label: 'Color:',
                          selectedValue: page.appBarTextColor,
                          items: DropdownColors.items,
                          onSelected: (val) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(appBarTextColor: val),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.bottomNavBarLabel,
                      style: context.style.s11w600.copyWith(letterSpacing: 1.5),
                    ),
                    Switch(
                      value: page.showBottomNav,
                      activeThumbColor: context.colors.violet,
                      onChanged: (val) {
                        context.read<BuilderBloc>().add(
                          UpdatePageSettingsEvent(showBottomNav: val),
                        );
                      },
                    ),
                  ],
                ),

                if (page.showBottomNav) ...[
                  const SizedBox(height: 16),
                  Text(context.l10n.bgColorLabel, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ColorPickerDropdown(
                          label: 'Custom:',
                          selectedValue: page.bottomNavBgColor,
                          onSelected: (value) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(bottomNavBgColor: value),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ColorDropDown(
                          label: 'Color:',
                          selectedValue: page.bottomNavBgColor,
                          items: DropdownColors.items,
                          onSelected: (val) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(bottomNavBgColor: val),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(context.l10n.activeTabColorLabel, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ColorPickerDropdown(
                          label: 'Custom:',
                          selectedValue: page.bottomNavActiveColor,
                          onSelected: (value) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(bottomNavActiveColor: value),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ColorDropDown(
                          label: 'Color:',
                          selectedValue: page.bottomNavActiveColor,
                          items: DropdownColors.items,
                          onSelected: (val) {
                            context.read<BuilderBloc>().add(
                              UpdatePageSettingsEvent(bottomNavActiveColor: val),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(context.l10n.tab1Label, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  TextPropertyInput(
                    value: page.bottomNavItems.isNotEmpty ? page.bottomNavItems[0] : 'Home',
                    placeholder: context.l10n.tab1Placeholder,
                    onChanged: (val) {
                      final items = List<String>.from(page.bottomNavItems);
                      if (items.isNotEmpty) {
                        items[0] = val;
                      } else {
                        items.add(val);
                      }
                      context.read<BuilderBloc>().add(
                        UpdatePageSettingsEvent(bottomNavItems: items),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(context.l10n.tab2Label, style: context.style.s12w500),
                  const SizedBox(height: 8),
                  TextPropertyInput(
                    value: page.bottomNavItems.length > 1 ? page.bottomNavItems[1] : 'Profile',
                    placeholder: context.l10n.tab2Placeholder,
                    onChanged: (val) {
                      final items = List<String>.from(page.bottomNavItems);
                      while (items.length < 2) {
                        items.add('Profile');
                      }
                      items[1] = val;
                      context.read<BuilderBloc>().add(
                        UpdatePageSettingsEvent(bottomNavItems: items),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: context.colors.borderDark, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DeleteButton(
                  onTap: () => context.read<BuilderBloc>().add(DeletePageEvent(page.id)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
