import '../../../../elements/models/builder_models.dart';

abstract class BuilderEvent {}

class SelectCategoryEvent extends BuilderEvent {
  final String category;
  SelectCategoryEvent(this.category);
}

class AddPageEvent extends BuilderEvent {
  final String name;
  AddPageEvent(this.name);
}

class DeletePageEvent extends BuilderEvent {
  final String pageId;
  DeletePageEvent(this.pageId);
}

class SelectPageEvent extends BuilderEvent {
  final String pageId;
  SelectPageEvent(this.pageId);
}

class RenamePageEvent extends BuilderEvent {
  final String pageId;
  final String newName;
  RenamePageEvent(this.pageId, this.newName);
}

class UpdatePageSettingsEvent extends BuilderEvent {
  final bool? showAppBar;
  final String? appBarTitle;
  final String? appBarBgColor;
  final String? appBarTextColor;
  final bool? showBottomNav;
  final String? bottomNavBgColor;
  final String? bottomNavActiveColor;
  final List<String>? bottomNavItems;

  UpdatePageSettingsEvent({
    this.showAppBar,
    this.appBarTitle,
    this.appBarBgColor,
    this.appBarTextColor,
    this.showBottomNav,
    this.bottomNavBgColor,
    this.bottomNavActiveColor,
    this.bottomNavItems,
  });
}

class AddElementEvent extends BuilderEvent {
  final ComponentType componentType;
  final String area;
  final double x;
  final double y;
  AddElementEvent(this.componentType, {required this.area, required this.x, required this.y});
}

class SetPendingElementEvent extends BuilderEvent {
  final ComponentType? componentType;
  SetPendingElementEvent(this.componentType);
}

class UpdateElementLayoutEvent extends BuilderEvent {
  final String id;
  final double? x;
  final double? y;
  final double? width;
  final double? height;

  UpdateElementLayoutEvent(this.id, {this.x, this.y, this.width, this.height});
}

class RemoveElementEvent extends BuilderEvent {
  final String id;
  RemoveElementEvent(this.id);
}

class SelectElementEvent extends BuilderEvent {
  final String? id;
  SelectElementEvent(this.id);
}

class MoveElementUpEvent extends BuilderEvent {
  final String id;
  MoveElementUpEvent(this.id);
}

class MoveElementDownEvent extends BuilderEvent {
  final String id;
  MoveElementDownEvent(this.id);
}

class ToggleGridEvent extends BuilderEvent {}

class ClearCanvasEvent extends BuilderEvent {}

class DuplicateElementEvent extends BuilderEvent {
  final String id;
  DuplicateElementEvent(this.id);
}

class UpdatePropertyEvent extends BuilderEvent {
  final String id;
  final String key;
  final String value;

  UpdatePropertyEvent(this.id, this.key, this.value);
}

class LoadTemplateProjectEvent extends BuilderEvent {
  final String templateName;
  LoadTemplateProjectEvent(this.templateName);
}

