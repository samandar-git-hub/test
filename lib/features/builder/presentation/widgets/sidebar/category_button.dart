import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class CategoryItem {
  final String id;
  final String label;
  final IconData icon;

  CategoryItem({required this.id, required this.label, required this.icon});
}

class CategoryButton extends StatefulWidget {
  final CategoryItem item;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final activeColor = colors.violet;
    final inactiveColor = colors.textMuted;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: widget.isActive
                ? activeColor.withValues(alpha: 0.08)
                : _isHovered
                ? colors.surfaceLight
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isActive ? activeColor.withValues(alpha: 0.15) : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: widget.isActive ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.item.icon,
                  color: widget.isActive
                      ? activeColor
                      : _isHovered
                      ? colors.textPrimary
                      : inactiveColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.item.label,
                style: (widget.isActive ? context.style.s10w600 : context.style.s10w500).copyWith(
                  color: widget.isActive
                      ? colors.textPrimary
                      : _isHovered
                      ? colors.textPrimary
                      : inactiveColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
