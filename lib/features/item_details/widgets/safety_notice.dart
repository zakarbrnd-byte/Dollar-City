import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class SafetyNotice extends StatelessWidget {
  const SafetyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.medium),
        decoration: BoxDecoration(
          color: AppColors.warmCream,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meet safely',
              style: AppTextStyles.label.copyWith(color: AppColors.darkGreen),
            ),
            const SizedBox(height: 6),
            Text(
              'Meet in a public place when possible. Do not send deposits or advance payments.',
              style: AppTextStyles.caption.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
