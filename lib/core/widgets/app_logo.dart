import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Simple text-based Dollar City logo (no image assets).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.showWordmark = true, this.size = 40});

  final bool showWordmark;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: Text(
            '\$1',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: size * 0.38,
              height: 1,
            ),
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(width: AppSpacing.small),
          Text(
            'Dollar City',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title.copyWith(
              color: AppColors.darkGreen,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ],
    );
  }
}
