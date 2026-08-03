import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/empty_state.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Sell')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.medium),
                decoration: BoxDecoration(
                  color: AppColors.warmCream,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  'All items on Dollar City are listed for exactly \$1.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: EmptyState(
                icon: Icons.add_circle_outline,
                title: 'Sell for \$1',
                description:
                    'List an item for exactly one dollar and arrange a local pickup.',
                actionLabel: 'Create a listing',
                actionIcon: Icons.sell_outlined,
                onActionPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Listing creation is coming next.'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
