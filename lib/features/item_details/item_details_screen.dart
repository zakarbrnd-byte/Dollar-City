import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/empty_state.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/status_badge.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/listing_status.dart';
import '../../data/models/market_item.dart';
import '../home/providers.dart';
import '../messages/chat_screen.dart';

class ItemDetailsScreen extends ConsumerWidget {
  const ItemDetailsScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(marketplaceItemsProvider);
    MarketItem? item;
    for (final candidate in items) {
      if (candidate.id == itemId) {
        item = candidate;
        break;
      }
    }

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Item')),
        body: const EmptyState(
          title: 'Item not found',
          message: 'This listing may have been removed.',
        ),
      );
    }

    final listing = item;
    final seller = MockData.userById(listing.sellerId);
    final isMine = listing.sellerId == MockData.currentUserId;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item details'),
        actions: [
          if (isMine)
            PopupMenuButton<ListingStatus>(
              tooltip: 'Update listing status',
              onSelected: (status) {
                ref
                    .read(marketplaceItemsProvider.notifier)
                    .updateStatus(listing.id, status);
              },
              itemBuilder: (context) => [
                for (final status in ListingStatus.values)
                  PopupMenuItem(
                    value: status,
                    child: Row(
                      children: [
                        if (listing.status == status)
                          const Icon(Icons.check, size: 18)
                        else
                          const SizedBox(width: 18),
                        const SizedBox(width: 8),
                        Text(status.label),
                      ],
                    ),
                  ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: listing.imageUrls.isEmpty
                ? const _DetailsImageFallback()
                : PageView.builder(
                    itemCount: listing.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        listing.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const _DetailsImageFallback(),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const ColoredBox(
                            color: Color(0xFFE8EEEA),
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        listing.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      listing.formattedPrice,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF1B6B4A),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    StatusBadge(status: listing.status),
                    const SizedBox(width: 10),
                    Text(
                      listing.condition.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  listing.description,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.4),
                ),
                const SizedBox(height: 20),
                _InfoRow(
                  icon: Icons.place_outlined,
                  label: 'Pickup area',
                  value: listing.pickupArea,
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Seller',
                  value: seller.name,
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.schedule_outlined,
                  label: 'Posted',
                  value: _formatPosted(listing.createdAt),
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.near_me_outlined,
                  label: 'Distance',
                  value: '${listing.distanceMiles.toStringAsFixed(1)} mi',
                ),
                const SizedBox(height: 8),
                Text(
                  'Exact address is shared privately after you arrange pickup.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref
                              .read(marketplaceItemsProvider.notifier)
                              .toggleSaved(listing.id);
                        },
                        icon: Icon(
                          listing.isSaved
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                        ),
                        label: Text(listing.isSaved ? 'Saved' : 'Save'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Message Seller',
                        icon: Icons.chat_bubble_outline,
                        onPressed: isMine
                            ? null
                            : () {
                                final conversationId = ref
                                    .read(conversationsProvider.notifier)
                                    .openOrCreateConversation(
                                      sellerId: seller.id,
                                      sellerName: seller.name,
                                      itemTitle: listing.title,
                                      avatarUrl: seller.avatarUrl,
                                    );
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => ChatScreen(
                                      conversationId: conversationId,
                                    ),
                                  ),
                                );
                              },
                      ),
                    ),
                  ],
                ),
                if (isMine) ...[
                  const SizedBox(height: 12),
                  Text(
                    'This is your listing. Use the menu to mark it Available, Reserved, or Sold.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPosted(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailsImageFallback extends StatelessWidget {
  const _DetailsImageFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFE8EEEA),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 56,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
