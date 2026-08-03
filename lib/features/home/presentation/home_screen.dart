import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/filter_chip_button.dart';
import '../../../core/widgets/guide_banner.dart';
import '../../../core/widgets/marketplace_list_item.dart';
import '../../../data/mock/mock_market_items.dart';
import '../../../navigation/navigation_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = MockMarketItems.all();
    final selectedFilters = ref.watch(selectedFiltersProvider);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const _HomeHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.medium,
              AppSpacing.small,
              AppSpacing.medium,
              0,
            ),
            child: AppSearchBar(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search is coming next.')),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.medium,
              ),
              children: [
                FilterChipButton(
                  label: 'Category',
                  selected: selectedFilters.contains('category'),
                  trailingIcon: Icons.keyboard_arrow_down,
                  onSelected: (_) => _toggleFilter(ref, 'category'),
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: 'Nearby',
                  selected: selectedFilters.contains('nearby'),
                  onSelected: (_) => _toggleFilter(ref, 'nearby'),
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: 'Available',
                  selected: selectedFilters.contains('available'),
                  leadingIcon: Icons.check_circle_outline,
                  onSelected: (_) => _toggleFilter(ref, 'available'),
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: 'Within 3 miles',
                  selected: selectedFilters.contains('within_3'),
                  leadingIcon: Icons.place_outlined,
                  onSelected: (_) => _toggleFilter(ref, 'within_3'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.medium,
                AppSpacing.small,
                AppSpacing.medium,
                AppSpacing.large,
              ),
              itemCount: items.length + 1,
              separatorBuilder: (_, index) {
                if (index == 0) {
                  return const SizedBox(height: AppSpacing.small);
                }
                return const Divider(height: 1);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GuideBanner(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Every item is \$1. Arrange pickup with the seller.',
                          ),
                        ),
                      );
                    },
                  );
                }

                final item = items[index - 1];
                return MarketplaceListItem(
                  item: item,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.title} details coming next.'),
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

  void _toggleFilter(WidgetRef ref, String id) {
    final current = {...ref.read(selectedFiltersProvider)};
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    ref.read(selectedFiltersProvider.notifier).state = current;
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        AppSpacing.medium - 2,
        AppSpacing.medium,
        AppSpacing.small,
      ),
      child: Row(
        children: [
          const AppLogo(fontSize: 24),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Location selection is coming next.'),
                ),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstants.defaultLocation,
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Account',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account is coming next.')),
              );
            },
            icon: const Icon(Icons.person_outline),
            color: AppColors.darkGreen,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                tooltip: 'Notifications',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications are coming next.'),
                    ),
                  );
                },
                icon: const Icon(Icons.notifications_none_outlined),
                color: AppColors.darkGreen,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.notificationDot,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
