// ===================================================================
// Visual Buildify - Dart Model Definitions
// ===================================================================

/// Supported component types that can be added to the canvas
enum ComponentType {
  button,
  input,
  text,
  card,
  image,
  divider,
  toggle,
  searchBar;

  String get displayName {
    switch (this) {
      case ComponentType.button:
        return 'Button';
      case ComponentType.input:
        return 'Input';
      case ComponentType.text:
        return 'Text';
      case ComponentType.card:
        return 'Card';
      case ComponentType.image:
        return 'Image';
      case ComponentType.divider:
        return 'Divider';
      case ComponentType.toggle:
        return 'Toggle';
      case ComponentType.searchBar:
        return 'Search Bar';
    }
  }
}

/// Property input type for the properties editor
enum PropertyInputType { text, select, color, number }

/// A single editable property definition
class PropertyDefinition {
  final String key;
  final String label;
  final PropertyInputType type;
  final List<String>? options;

  const PropertyDefinition({
    required this.key,
    required this.label,
    required this.type,
    this.options,
  });
}

/// A single UI element placed on the canvas
class CanvasElement {
  final String id;
  final ComponentType type;
  final Map<String, String> properties;
  final int createdAt;

  CanvasElement({
    required this.id,
    required this.type,
    required this.properties,
    required this.createdAt,
  });

  CanvasElement copyWith({Map<String, String>? properties}) {
    return CanvasElement(
      id: id,
      type: type,
      properties: properties ?? Map.from(this.properties),
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.displayName,
      'properties': properties,
      'createdAt': createdAt,
    };
  }
}

/// Component template definition used in the sidebar
class ComponentTemplate {
  final ComponentType type;
  final String label;
  final String icon;
  final String description;
  final Map<String, String> defaultProperties;
  final List<PropertyDefinition> editableProperties;
  final String category;

  const ComponentTemplate({
    required this.type,
    required this.label,
    required this.icon,
    required this.description,
    required this.defaultProperties,
    required this.editableProperties,
    required this.category,
  });
}

/// Represents a screen / page in the visual builder
class BuilderPage {
  final String id;
  String name;
  final List<CanvasElement> elements;
  bool showAppBar;
  String appBarTitle;
  String appBarBgColor;
  String appBarTextColor;

  bool showBottomNav;
  String bottomNavBgColor;
  String bottomNavActiveColor;
  List<String> bottomNavItems; // e.g. ["Home", "Profile"]

  BuilderPage({
    required this.id,
    required this.name,
    required this.elements,
    this.showAppBar = false,
    this.appBarTitle = 'Bosh sahifa',
    this.appBarBgColor = '#ffffff',
    this.appBarTextColor = '#0F172A',
    this.showBottomNav = false,
    this.bottomNavBgColor = '#ffffff',
    this.bottomNavActiveColor = '#3b82f6',
    List<String>? bottomNavItems,
  }) : bottomNavItems = bottomNavItems ?? ['Home', 'Profile'];

  BuilderPage copyWith({
    String? name,
    List<CanvasElement>? elements,
    bool? showAppBar,
    String? appBarTitle,
    String? appBarBgColor,
    String? appBarTextColor,
    bool? showBottomNav,
    String? bottomNavBgColor,
    String? bottomNavActiveColor,
    List<String>? bottomNavItems,
  }) {
    return BuilderPage(
      id: id,
      name: name ?? this.name,
      elements: elements ?? List.from(this.elements),
      showAppBar: showAppBar ?? this.showAppBar,
      appBarTitle: appBarTitle ?? this.appBarTitle,
      appBarBgColor: appBarBgColor ?? this.appBarBgColor,
      appBarTextColor: appBarTextColor ?? this.appBarTextColor,
      showBottomNav: showBottomNav ?? this.showBottomNav,
      bottomNavBgColor: bottomNavBgColor ?? this.bottomNavBgColor,
      bottomNavActiveColor: bottomNavActiveColor ?? this.bottomNavActiveColor,
      bottomNavItems: bottomNavItems ?? List.from(this.bottomNavItems),
    );
  }
}
