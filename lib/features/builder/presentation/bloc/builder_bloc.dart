import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../elements/elements.dart';
import '../../../../elements/models/builder_models.dart';
import 'builder_event.dart';
import 'builder_state.dart';

class BuilderBloc extends Bloc<BuilderEvent, BuilderState> {
  static const _uuid = Uuid();

  BuilderBloc()
    : super(
        BuilderState(
          pages: [
            BuilderPage(
              id: 'page_home',
              name: 'Bosh sahifa',
              elements: const [],
              appBarTitle: 'Bosh sahifa',
            ),
          ],
          activePageId: 'page_home',
          selectedCategory: 'Barchasi',
          showGrid: false,
        ),
      ) {
    on<SelectCategoryEvent>((event, emit) {
      if (state.selectedCategory == event.category) return;
      emit(state.copyWith(selectedCategory: event.category));
    });

    on<AddPageEvent>((event, emit) {
      final newPageId = 'page_${_uuid.v4().substring(0, 8)}';
      final newPage = BuilderPage(
        id: newPageId,
        name: event.name,
        elements: const [],
        appBarTitle: event.name,
      );
      final updatedPages = List<BuilderPage>.from(state.pages)..add(newPage);
      emit(
        state.copyWithWithActiveElement(
          pages: updatedPages,
          activePageId: newPage.id,
          activeElementId: null,
        ),
      );
    });

    on<DeletePageEvent>((event, emit) {
      if (state.pages.length <= 1) return; // Cannot delete the only page
      final updatedPages = List<BuilderPage>.from(state.pages)
        ..removeWhere((p) => p.id == event.pageId);

      String newActivePageId = state.activePageId!;
      String? newActiveElementId = state.activeElementId;

      if (state.activePageId == event.pageId) {
        newActivePageId = updatedPages.first.id;
        newActiveElementId = null;
      }

      emit(
        state.copyWithWithActiveElement(
          pages: updatedPages,
          activePageId: newActivePageId,
          activeElementId: newActiveElementId,
        ),
      );
    });

    on<SelectPageEvent>((event, emit) {
      emit(state.copyWithWithActiveElement(activePageId: event.pageId, activeElementId: null));
    });

    on<RenamePageEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == event.pageId) {
          final updatedElements = p.elements.map((el) {
            if (el.properties['area'] == 'appBar' &&
                el.id.contains('appbar_title') &&
                el.properties['text'] == p.name) {
              final props = Map<String, String>.from(el.properties);
              props['text'] = event.newName;
              return el.copyWith(properties: props);
            }
            return el;
          }).toList();

          final updatedPage = p.copyWith(
            name: event.newName,
            appBarTitle: event.newName,
            elements: updatedElements,
          );
          return updatedPage;
        }
        return p;
      }).toList();

      emit(state.copyWith(pages: updatedPages));
    });

    on<UpdatePageSettingsEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          final showAppBarChanged = event.showAppBar != null && event.showAppBar != p.showAppBar;
          final showBottomNavChanged =
              event.showBottomNav != null && event.showBottomNav != p.showBottomNav;

          var elements = List<CanvasElement>.from(p.elements);

          if (showAppBarChanged) {
            if (event.showAppBar == true) {
              final hasTitle = elements.any(
                (el) => el.properties['area'] == 'appBar' && el.id.contains('appbar_title'),
              );
              if (!hasTitle) {
                elements.add(
                  CanvasElement(
                    id: 'appbar_title_${_uuid.v4().substring(0, 4)}',
                    type: ComponentType.text,
                    properties: {
                      'text': event.appBarTitle ?? p.appBarTitle,
                      'textColor': event.appBarTextColor ?? p.appBarTextColor,
                      'fontSize': '16',
                      'fontWeight': 'semibold',
                      'x': '96',
                      'y': '8',
                      'width': '200',
                      'height': '24',
                      'area': 'appBar',
                    },
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                  ),
                );
              }
            } else if (event.showAppBar == false) {
              elements.removeWhere((el) => el.properties['area'] == 'appBar');
            }
          }

          if (showBottomNavChanged) {
            if (event.showBottomNav == true) {
              final hasBottom = elements.any(
                (el) => el.properties['area'] == 'bottomNav' && el.id.contains('bottom_nav_item'),
              );
              if (!hasBottom) {
                elements.addAll([
                  CanvasElement(
                    id: 'bottom_nav_item_0_${_uuid.v4().substring(0, 4)}',
                    type: ComponentType.text,
                    properties: {
                      'text': 'Home',
                      'textColor': '#3b82f6',
                      'fontSize': '12',
                      'fontWeight': 'semibold',
                      'x': '40',
                      'y': '10',
                      'width': '80',
                      'height': '36',
                      'area': 'bottomNav',
                    },
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                  ),
                  CanvasElement(
                    id: 'bottom_nav_item_1_${_uuid.v4().substring(0, 4)}',
                    type: ComponentType.text,
                    properties: {
                      'text': 'Profile',
                      'textColor': '#64748B',
                      'fontSize': '12',
                      'fontWeight': 'medium',
                      'x': '240',
                      'y': '10',
                      'width': '80',
                      'height': '36',
                      'area': 'bottomNav',
                    },
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                  ),
                ]);
              }
            } else if (event.showBottomNav == false) {
              elements.removeWhere((el) => el.properties['area'] == 'bottomNav');
            }
          }

          if (event.appBarTitle != null) {
            elements = elements.map((el) {
              if (el.properties['area'] == 'appBar' && el.id.contains('appbar_title')) {
                final props = Map<String, String>.from(el.properties);
                props['text'] = event.appBarTitle!;
                return el.copyWith(properties: props);
              }
              return el;
            }).toList();
          }

          if (event.bottomNavItems != null) {
            elements = elements.map((el) {
              if (el.properties['area'] == 'bottomNav') {
                if (el.id.contains('bottom_nav_item_0') && event.bottomNavItems!.isNotEmpty) {
                  final props = Map<String, String>.from(el.properties);
                  props['text'] = event.bottomNavItems![0];
                  return el.copyWith(properties: props);
                } else if (el.id.contains('bottom_nav_item_1') &&
                    event.bottomNavItems!.length > 1) {
                  final props = Map<String, String>.from(el.properties);
                  props['text'] = event.bottomNavItems![1];
                  return el.copyWith(properties: props);
                }
              }
              return el;
            }).toList();
          }

          return p.copyWith(
            showAppBar: event.showAppBar,
            appBarTitle: event.appBarTitle,
            appBarBgColor: event.appBarBgColor,
            appBarTextColor: event.appBarTextColor,
            showBottomNav: event.showBottomNav,
            bottomNavBgColor: event.bottomNavBgColor,
            bottomNavActiveColor: event.bottomNavActiveColor,
            bottomNavItems: event.bottomNavItems,
            elements: elements,
          );
        }
        return p;
      }).toList();
      emit(state.copyWith(pages: updatedPages));
    });

    on<SetPendingElementEvent>((event, emit) {
      emit(
        state.copyWith(
          pendingPlacementType: event.componentType,
          clearPendingPlacement: event.componentType == null,
        ),
      );
    });

    on<AddElementEvent>((event, emit) {
      final template = getTemplateByType(event.componentType);
      final properties = Map<String, String>.from(template.defaultProperties);

      properties['x'] = event.x.round().toString();
      properties['y'] = event.y.round().toString();
      properties['area'] = event.area;
      properties.putIfAbsent('width', () => '200');
      properties.putIfAbsent('height', () => '80');

      final newElement = CanvasElement(
        id: 'el_${_uuid.v4().substring(0, 8)}',
        type: event.componentType,
        properties: properties,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          // Add element to active page's elements list
          final updatedElements = List<CanvasElement>.from(p.elements)..add(newElement);
          return p.copyWith(elements: updatedElements);
        }
        return p;
      }).toList();

      emit(
        state.copyWithWithActiveElement(
          pages: updatedPages,
          activeElementId: newElement.id,
          clearPendingPlacement: true,
        ),
      );
    });

    on<UpdateElementLayoutEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          final updatedElements = p.elements.map((el) {
            if (el.id == event.id) {
              final props = Map<String, String>.from(el.properties);
              if (event.x != null) props['x'] = event.x!.round().toString();
              if (event.y != null) props['y'] = event.y!.round().toString();
              if (event.width != null) props['width'] = event.width!.round().toString();
              if (event.height != null) props['height'] = event.height!.round().toString();
              return el.copyWith(properties: props);
            }
            return el;
          }).toList();
          return p.copyWith(elements: updatedElements);
        }
        return p;
      }).toList();

      emit(state.copyWith(pages: updatedPages));
    });

    on<RemoveElementEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          final updatedElements = List<CanvasElement>.from(p.elements)
            ..removeWhere((el) => el.id == event.id);
          return p.copyWith(elements: updatedElements);
        }
        return p;
      }).toList();

      String? newActiveElementId = state.activeElementId;
      if (state.activeElementId == event.id) {
        newActiveElementId = null;
      }

      emit(
        state.copyWithWithActiveElement(pages: updatedPages, activeElementId: newActiveElementId),
      );
    });

    on<SelectElementEvent>((event, emit) {
      emit(state.copyWithWithActiveElement(activeElementId: event.id));
    });

    on<MoveElementUpEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          final index = p.elements.indexWhere((el) => el.id == event.id);
          if (index <= 0) return p;
          final updatedElements = List<CanvasElement>.from(p.elements);
          final temp = updatedElements[index];
          updatedElements[index] = updatedElements[index - 1];
          updatedElements[index - 1] = temp;
          return p.copyWith(elements: updatedElements);
        }
        return p;
      }).toList();

      emit(state.copyWith(pages: updatedPages));
    });

    on<MoveElementDownEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          final index = p.elements.indexWhere((el) => el.id == event.id);
          if (index == -1 || index >= p.elements.length - 1) return p;
          final updatedElements = List<CanvasElement>.from(p.elements);
          final temp = updatedElements[index];
          updatedElements[index] = updatedElements[index + 1];
          updatedElements[index + 1] = temp;
          return p.copyWith(elements: updatedElements);
        }
        return p;
      }).toList();

      emit(state.copyWith(pages: updatedPages));
    });

    on<ToggleGridEvent>((event, emit) {
      emit(state.copyWith(showGrid: !state.showGrid));
    });

    on<ClearCanvasEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          return p.copyWith(elements: []);
        }
        return p;
      }).toList();

      emit(state.copyWithWithActiveElement(pages: updatedPages, activeElementId: null));
    });

    on<DuplicateElementEvent>((event, emit) {
      final activePage = state.activePage;
      final index = activePage.elements.indexWhere((el) => el.id == event.id);
      if (index == -1) return;

      final original = activePage.elements[index];
      final props = Map<String, String>.from(original.properties);

      final double currentX = double.tryParse(props['x'] ?? '40') ?? 40.0;
      final double currentY = double.tryParse(props['y'] ?? '100') ?? 100.0;
      props['x'] = (currentX + 20.0).toString();
      props['y'] = (currentY + 20.0).toString();

      final duplicate = CanvasElement(
        id: 'el_${_uuid.v4().substring(0, 8)}',
        type: original.type,
        properties: props,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          final updatedElements = List<CanvasElement>.from(p.elements)..add(duplicate);
          return p.copyWith(elements: updatedElements);
        }
        return p;
      }).toList();

      emit(state.copyWithWithActiveElement(pages: updatedPages, activeElementId: duplicate.id));
    });

    on<UpdatePropertyEvent>((event, emit) {
      final updatedPages = state.pages.map((p) {
        if (p.id == state.activePageId) {
          String? appBarTitle = p.appBarTitle;
          List<String>? bottomNavItems = List.from(p.bottomNavItems);

          final updatedElements = p.elements.map((el) {
            if (el.id == event.id) {
              final props = Map<String, String>.from(el.properties);
              props[event.key] = event.value;

              if (el.properties['area'] == 'appBar' &&
                  el.id.contains('appbar_title') &&
                  event.key == 'text') {
                appBarTitle = event.value;
              } else if (el.properties['area'] == 'bottomNav' && event.key == 'text') {
                if (el.id.contains('bottom_nav_item_0')) {
                  bottomNavItems[0] = event.value;
                } else if (el.id.contains('bottom_nav_item_1') && bottomNavItems.length > 1) {
                  bottomNavItems[1] = event.value;
                }
              }

              return el.copyWith(properties: props);
            }
            return el;
          }).toList();
          return p.copyWith(
            elements: updatedElements,
            appBarTitle: appBarTitle,
            bottomNavItems: bottomNavItems,
          );
        }
        return p;
      }).toList();

      emit(state.copyWith(pages: updatedPages));
    });

    on<LoadTemplateProjectEvent>((event, emit) {
      final newPage = BuilderPage(
        id: 'page_home',
        name: 'Bosh sahifa',
        elements: [
          CanvasElement(
            id: 'appbar_title_home',
            type: ComponentType.text,
            properties: {
              'text': 'Bosh sahifa',
              'textColor': '#0F172A',
              'fontSize': '16',
              'fontWeight': 'semibold',
              'x': '96',
              'y': '8',
              'width': '200',
              'height': '24',
              'area': 'appBar',
            },
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        ],
        appBarTitle: 'Bosh sahifa',
      );

      emit(
        state.copyWithWithActiveElement(
          pages: [newPage],
          activePageId: 'page_home',
          activeElementId: null,
        ),
      );
    });
  }
}
