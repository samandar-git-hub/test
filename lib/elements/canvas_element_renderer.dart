import 'package:flutter/material.dart';

import 'models/builder_models.dart';
import 'elements.dart';

class CanvasElementRenderer extends StatelessWidget {
  final CanvasElement element;

  const CanvasElementRenderer({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final p = element.properties;

    switch (element.type) {
      case ComponentType.button:
        return ButtonElement(properties: p);
      case ComponentType.input:
        return InputElement(properties: p);
      case ComponentType.text:
        return TextElement(properties: p);
      case ComponentType.card:
        return CardElement(properties: p);
      case ComponentType.image:
        return ImageElement(properties: p);
      case ComponentType.divider:
        return DividerElement(properties: p);
      case ComponentType.toggle:
        return ToggleElement(properties: p);
      case ComponentType.searchBar:
        return SearchBarElement(properties: p);
    }
  }
}
