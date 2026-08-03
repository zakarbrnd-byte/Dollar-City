import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'primary_button.dart';

/// Reusable empty/placeholder layout.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onActionPressed,
    this.actionIcon,
    this.child,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final IconData? actionIcon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.lightMint,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(icon, size: 34, color: AppColors.darkGreen),
              ),
              const SizedBox(height: AppSpacing.large),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (child != null) ...[
                const SizedBox(height: AppSpacing.large),
                child!,
              ],
              if (actionLabel != null) ...[
                const SizedBox(height: AppSpacing.large),
                PrimaryButton(
                  label: actionLabel!,
                  icon: actionIcon,
                  onPressed: onActionPressed,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
