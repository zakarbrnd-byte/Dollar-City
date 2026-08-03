import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/category_filter_chip.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/marketplace_post_tile.dart';
import '../../data/models/item_category.dart';
import '../item_details/item_details_screen.dart';
import 'providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);
    final items = ref.watch(filteredItemsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const AppLogo(size: 32),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Pickup only · \$1',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: ItemCategory.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = ItemCategory.values[index];
                return CategoryFilterChip(
                  category: category,
                  selected: selected == category,
                  onSelected: (_) {
                    ref.read(selectedCategoryProvider.notifier).state =
                        category;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? EmptyState(
                    title: 'No listings yet',
                    message: selected == ItemCategory.all
                        ? 'Check back soon for \$1 pickup finds near you.'
                        : 'Nothing in ${selected.label} right now.',
                    icon: Icons.storefront_outlined,
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return MarketplacePostTile(
                        item: item,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  ItemDetailsScreen(itemId: item.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
