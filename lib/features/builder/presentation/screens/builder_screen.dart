import 'package:flutter/material.dart';

import 'body_sidebar.dart';
import 'canvas_widget.dart';
import 'category_sidebar.dart';
import 'components_sidebar.dart';

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          CategorySidebar(),
          ComponentsSidebar(),
          CanvasWidget(),
          BodySidebar(),
        ],
      ),
    );
  }
}
