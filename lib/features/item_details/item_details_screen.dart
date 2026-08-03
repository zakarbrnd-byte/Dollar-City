import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/models/listing_status.dart';
import '../../data/models/market_item.dart';
import '../home/providers.dart';
import '../messages/chat_screen.dart';
import 'widgets/pickup_section.dart';
import 'widgets/product_bottom_action_bar.dart';
import 'widgets/product_image_gallery.dart';
import 'widgets/product_info_section.dart';
import 'widgets/safety_notice.dart';
import 'widgets/seller_section.dart';

class ItemDetailsScreen extends ConsumerStatefulWidget {
  const ItemDetailsScreen({super.key, required this.itemId});

  final String itemId;

  @override
  ConsumerState<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends ConsumerState<ItemDetailsScreen> {
  var _didIncrementViews = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didIncrementViews) return;
      final exists = ref
          .read(marketplaceItemsProvider.notifier)
          .byId(widget.itemId);
      if (exists == null) return;
      _didIncrementViews = true;
      ref
          .read(marketplaceItemsProvider.notifier)
          .incrementViewCount(widget.itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(marketplaceItemsProvider);
    MarketItem? item;
    for (final candidate in items) {
      if (candidate.id == widget.itemId) {
        item = candidate;
        break;
      }
    }

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Item')),
        body: EmptyState(
          icon: Icons.search_off_outlined,
          title: 'Item not found',
          message: 'This listing may have been removed.',
          action: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: PrimaryButton(
              label: 'Back to marketplace',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      );
    }

    final listing = item;
    final seller = ref.watch(sellerByIdProvider(listing.sellerId));
    final currentUser = ref.watch(currentUserProvider);
    final isOwner = listing.sellerId == currentUser.id;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            title: const Text('Product details'),
            actions: [
              IconButton(
                tooltip: listing.isSaved ? 'Unsave' : 'Save',
                onPressed: () {
                  ref
                      .read(marketplaceItemsProvider.notifier)
                      .toggleSaved(listing.id);
                },
                icon: Icon(
                  listing.isSaved ? Icons.favorite : Icons.favorite_border,
                  color: listing.isSaved
                      ? AppColors.error
                      : AppColors.darkGreen,
                ),
              ),
              IconButton(
                tooltip: 'Share',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing is coming later.')),
                  );
                },
                icon: const Icon(Icons.ios_share_outlined),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: ProductImageGallery(imageUrls: listing.imageUrls),
          ),
          SliverToBoxAdapter(child: ProductInfoSection(item: listing)),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.large)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: AppTextStyles.title),
                  const SizedBox(height: 8),
                  Text(
                    listing.description,
                    style: AppTextStyles.body.copyWith(height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.large)),
          SliverToBoxAdapter(child: PickupSection(item: listing)),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.large)),
          SliverToBoxAdapter(child: SellerSection(seller: seller)),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.large)),
          const SliverToBoxAdapter(child: SafetyNotice()),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
      bottomNavigationBar: ProductBottomActionBar(
        item: listing,
        isOwner: isOwner,
        onSave: () {
          ref.read(marketplaceItemsProvider.notifier).toggleSaved(listing.id);
        },
        onMessageSeller: () {
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
              builder: (_) => ChatScreen(conversationId: conversationId),
            ),
          );
        },
        onChangeStatus: (ListingStatus status) {
          ref
              .read(marketplaceItemsProvider.notifier)
              .updateStatus(listing.id, status);
        },
        onEditListing: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Editing is coming next.')),
          );
        },
      ),
    );
  }
}
