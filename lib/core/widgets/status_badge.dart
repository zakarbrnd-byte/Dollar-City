import 'package:flutter/material.dart';

import '../../data/models/listing_status.dart';
import '../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ListingStatus status;

  Color get _background {
    switch (status) {
      case ListingStatus.available:
        return AppColors.lightMint;
      case ListingStatus.reserved:
        return const Color(0xFFF8F1DF);
      case ListingStatus.sold:
        return const Color(0xFFEEF1EF);
    }
  }

  Color get _foreground {
    switch (status) {
      case ListingStatus.available:
        return AppColors.darkGreen;
      case ListingStatus.reserved:
        return const Color(0xFF8A6A16);
      case ListingStatus.sold:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(6),
        border: status == ListingStatus.reserved
            ? Border.all(color: AppColors.softGold.withValues(alpha: 0.45))
            : null,
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: _foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
