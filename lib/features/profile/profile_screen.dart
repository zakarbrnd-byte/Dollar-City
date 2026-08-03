import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/empty_state.dart';
import '../../core/widgets/item_card.dart';
import '../../core/widgets/status_badge.dart';
import '../../core/widgets/user_avatar.dart';
import '../../data/models/listing_status.dart';
import '../../data/models/market_item.dart';
import '../home/providers.dart';
import '../item_details/item_details_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final active = ref.watch(myActiveListingsProvider);
    final reserved = ref.watch(myReservedListingsProvider);
    final sold = ref.watch(mySoldListingsProvider);
    final saved = ref.watch(savedItemsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  UserAvatar(
                    imageUrl: user.avatarUrl,
                    name: user.name,
                    radius: 34,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pickup area: ${user.pickupArea}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: Colors.amber.shade700,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${user.rating.toStringAsFixed(1)} rating',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _ListingSection(
            title: 'Active Listings',
            items: active,
            emptyMessage: 'You have no active listings.',
            onStatusChange: (item, status) {
              ref
                  .read(marketplaceItemsProvider.notifier)
                  .updateStatus(item.id, status);
            },
          ),
          const SizedBox(height: 16),
          _ListingSection(
            title: 'Reserved Listings',
            items: reserved,
            emptyMessage: 'No reserved listings.',
            onStatusChange: (item, status) {
              ref
                  .read(marketplaceItemsProvider.notifier)
                  .updateStatus(item.id, status);
            },
          ),
          const SizedBox(height: 16),
          _ListingSection(
            title: 'Sold Listings',
            items: sold,
            emptyMessage: 'No sold listings yet.',
            onStatusChange: (item, status) {
              ref
                  .read(marketplaceItemsProvider.notifier)
                  .updateStatus(item.id, status);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Saved Items',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          if (saved.isEmpty)
            const EmptyState(
              title: 'No saved items',
              message: 'Tap Save on a listing to keep it here.',
              icon: Icons.bookmark_border,
            )
          else
            ...[
              for (final item in saved) ...[
                ItemCard(
                  item: item,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ItemDetailsScreen(itemId: item.id),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
            ],
        ],
      ),
    );
  }
}

class _ListingSection extends StatelessWidget {
  const _ListingSection({
    required this.title,
    required this.items,
    required this.emptyMessage,
    required this.onStatusChange,
  });

  final String title;
  final List<MarketItem> items;
  final String emptyMessage;
  final void Function(MarketItem item, ListingStatus status) onStatusChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              emptyMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          )
        else
          ...[
            for (final item in items) ...[
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: item.imageUrls.isEmpty
                          ? const ColoredBox(
                              color: Color(0xFFE8EEEA),
                              child: Icon(Icons.image_outlined),
                            )
                          : Image.network(
                              item.imageUrls.first,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const ColoredBox(
                                color: Color(0xFFE8EEEA),
                                child: Icon(Icons.image_outlined),
                              ),
                            ),
                    ),
                  ),
                  title: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: StatusBadge(status: item.status),
                  ),
                  trailing: PopupMenuButton<ListingStatus>(
                    tooltip: 'Change status',
                    onSelected: (status) => onStatusChange(item, status),
                    itemBuilder: (context) => [
                      for (final status in ListingStatus.values)
                        PopupMenuItem(
                          value: status,
                          child: Text(status.label),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ItemDetailsScreen(itemId: item.id),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
      ],
    );
  }
}
