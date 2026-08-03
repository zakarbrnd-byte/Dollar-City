import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/empty_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: EmptyState(
          icon: Icons.person_outline,
          title: 'Profile',
          description: 'Manage your listings, saved items, and account.',
          child: Column(
            children: const [
              _ProfileRow(
                icon: Icons.inventory_2_outlined,
                label: 'My Listings',
              ),
              SizedBox(height: AppSpacing.small),
              _ProfileRow(icon: Icons.bookmark_border, label: 'Saved Items'),
              SizedBox(height: AppSpacing.small),
              _ProfileRow(icon: Icons.history, label: 'Pickup History'),
              SizedBox(height: AppSpacing.small),
              _ProfileRow(icon: Icons.settings_outlined, label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkGreen),
          const SizedBox(width: AppSpacing.medium),
          Expanded(child: Text(label, style: AppTextStyles.label)),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
