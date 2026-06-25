import '../../../../elements/models/builder_models.dart';

class BuilderState {
  final List<BuilderPage> pages;
  final String? activePageId;
  final String? activeElementId;
  final String selectedCategory;
  final bool showGrid;
  final ComponentType? pendingPlacementType;

  BuilderState({
    required this.pages,
    this.activePageId,
    this.activeElementId,
    required this.selectedCategory,
    required this.showGrid,
    this.pendingPlacementType,
  });

  BuilderPage get activePage {
    return pages.firstWhere(
      (p) => p.id == activePageId,
      orElse: () => pages.first,
    );
  }

  List<CanvasElement> get elements => activePage.elements;

  CanvasElement? get activeElement {
    if (activeElementId == null) return null;
    try {
      return activePage.elements.firstWhere((el) => el.id == activeElementId);
    } catch (_) {
      return null;
    }
  }

  BuilderState copyWith({
    List<BuilderPage>? pages,
    String? activePageId,
    String? activeElementId,
    String? selectedCategory,
    bool? showGrid,
    ComponentType? pendingPlacementType,
    bool clearPendingPlacement = false,
  }) {
    return BuilderState(
      pages: pages ?? this.pages,
      activePageId: activePageId ?? this.activePageId,
      activeElementId: activeElementId ?? this.activeElementId,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      showGrid: showGrid ?? this.showGrid,
      pendingPlacementType: clearPendingPlacement ? null : (pendingPlacementType ?? this.pendingPlacementType),
    );
  }

  BuilderState copyWithWithActiveElement({
    List<BuilderPage>? pages,
    String? activePageId,
    required String? activeElementId,
    String? selectedCategory,
    bool? showGrid,
    ComponentType? pendingPlacementType,
    bool clearPendingPlacement = false,
  }) {
    return BuilderState(
      pages: pages ?? this.pages,
      activePageId: activePageId ?? this.activePageId,
      activeElementId: activeElementId,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      showGrid: showGrid ?? this.showGrid,
      pendingPlacementType: clearPendingPlacement ? null : (pendingPlacementType ?? this.pendingPlacementType),
    );
  }
}
