import 'package:flutter/material.dart';
import 'package:visual_buildify/core/theme/app_theme.dart';

import '../../../../../elements/models/builder_models.dart';

class ComponentButton extends StatefulWidget {
  final ComponentTemplate template;
  final VoidCallback onTap;
  final bool isSelected;

  const ComponentButton({
    super.key,
    required this.template,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  State<ComponentButton> createState() => _ComponentButtonState();
}

class _ComponentButtonState extends State<ComponentButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? colors.violet.withValues(alpha: 0.15)
                  : (_isHovered ? colors.surfaceLight : colors.surface.withValues(alpha: 0.4)),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isSelected
                    ? colors.violet
                    : (_isHovered ? colors.borderMedium : colors.borderDark),
                width: widget.isSelected ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.isSelected || _isHovered
                          ? [
                              colors.violet.withValues(alpha: 0.2),
                              colors.blue.withValues(alpha: 0.2),
                            ]
                          : [colors.surfaceLight, colors.surfaceLight.withValues(alpha: 0.5)],
                    ),
                  ),
                  child: Center(
                    child: Text(widget.template.icon, style: const TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.template.label, style: context.style.s14w500),
                      const SizedBox(height: 2),
                      Text(
                        widget.template.description,
                        style: context.style.s11w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: (widget.isSelected || _isHovered) ? 1.0 : 0.0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.surfaceLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      widget.isSelected ? Icons.close : Icons.add,
                      size: 14,
                      color: widget.isSelected ? Colors.red : colors.violet.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PulsingDot extends StatefulWidget {
  const PulsingDot({super.key});

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.emerald.withValues(alpha: 0.5 + _controller.value * 0.5),
            boxShadow: [
              BoxShadow(
                color: colors.emerald.withValues(alpha: _controller.value * 0.4),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
