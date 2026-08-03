import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/models/market_item.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.item});

  final MarketItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        AppSpacing.medium,
        AppSpacing.medium,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(status: item.status),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: AppTextStyles.headline.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            item.formattedPrice,
            style: AppTextStyles.price.copyWith(
              fontSize: 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Posted ${item.createdAtLabel} · ${item.viewCount} views',
            style: AppTextStyles.caption.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            '${item.category.label} · ${item.condition.label} condition',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
