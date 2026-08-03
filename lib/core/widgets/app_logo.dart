import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Text logo with split coloring: Dollar (green) + City (dark green).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.fontSize = 24, this.showMark = false});

  final double fontSize;
  final bool showMark;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.display.copyWith(fontSize: fontSize, height: 1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMark) ...[
          Container(
            width: fontSize + 4,
            height: fontSize + 4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '\$1',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: fontSize * 0.42,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Dollar',
                style: style.copyWith(color: AppColors.primary),
              ),
              TextSpan(
                text: ' City',
                style: style.copyWith(color: AppColors.darkGreen),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
