import 'package:flutter/material.dart';

import '../../data/models/listing_status.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ListingStatus status;

  Color _background(BuildContext context) {
    switch (status) {
      case ListingStatus.available:
        return const Color(0xFFE6F4EC);
      case ListingStatus.reserved:
        return const Color(0xFFFFF4E0);
      case ListingStatus.sold:
        return const Color(0xFFF0F0F0);
    }
  }

  Color _foreground(BuildContext context) {
    switch (status) {
      case ListingStatus.available:
        return const Color(0xFF1B6B4A);
      case ListingStatus.reserved:
        return const Color(0xFF9A6700);
      case ListingStatus.sold:
        return const Color(0xFF5F6368);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _background(context),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: _foreground(context),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
