import 'package:flutter/material.dart';

import '../../data/models/item_category.dart';
import '../theme/app_colors.dart';

class CategoryFilterChip extends StatelessWidget {
  const CategoryFilterChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelected,
  });

  final ItemCategory category;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(category.label),
      selected: selected,
      showCheckmark: false,
      onSelected: onSelected,
      selectedColor: AppColors.lightMint,
      backgroundColor: AppColors.surface,
      side: BorderSide(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.35)
            : AppColors.border,
      ),
      labelStyle: TextStyle(
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        color: selected ? AppColors.darkGreen : AppColors.textPrimary,
      ),
    );
  }
}
