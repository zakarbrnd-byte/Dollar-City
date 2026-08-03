import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/models/listing_status.dart';
import '../../../data/models/market_item.dart';

class ProductBottomActionBar extends StatelessWidget {
  const ProductBottomActionBar({
    super.key,
    required this.item,
    required this.isOwner,
    required this.onSave,
    required this.onMessageSeller,
    required this.onChangeStatus,
    required this.onEditListing,
  });

  final MarketItem item;
  final bool isOwner;
  final VoidCallback onSave;
  final VoidCallback onMessageSeller;
  final ValueChanged<ListingStatus> onChangeStatus;
  final VoidCallback onEditListing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.medium,
            12,
            AppSpacing.medium,
            12,
          ),
          child: isOwner
              ? _OwnerActions(
                  item: item,
                  onEditListing: onEditListing,
                  onChangeStatus: onChangeStatus,
                )
              : _BuyerActions(
                  isSaved: item.isSaved,
                  onSave: onSave,
                  onMessageSeller: onMessageSeller,
                ),
        ),
      ),
    );
  }
}

class _BuyerActions extends StatelessWidget {
  const _BuyerActions({
    required this.isSaved,
    required this.onSave,
    required this.onMessageSeller,
  });

  final bool isSaved;
  final VoidCallback onSave;
  final VoidCallback onMessageSeller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onSave,
            icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border),
            label: Text(isSaved ? 'Saved' : 'Save'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: PrimaryButton(
            label: 'Message seller',
            icon: Icons.chat_bubble_outline,
            onPressed: onMessageSeller,
          ),
        ),
      ],
    );
  }
}

class _OwnerActions extends StatelessWidget {
  const _OwnerActions({
    required this.item,
    required this.onEditListing,
    required this.onChangeStatus,
  });

  final MarketItem item;
  final VoidCallback onEditListing;
  final ValueChanged<ListingStatus> onChangeStatus;

  Future<void> _showStatusSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<ListingStatus>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  'Change listing status',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              for (final status in ListingStatus.values)
                ListTile(
                  leading: Icon(
                    item.status == status
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(status.label),
                  onTap: () => Navigator.of(context).pop(status),
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
    if (selected != null) onChangeStatus(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onEditListing,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit listing'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryButton(
            label: 'Change status',
            icon: Icons.tune,
            onPressed: () => _showStatusSheet(context),
          ),
        ),
      ],
    );
  }
}
