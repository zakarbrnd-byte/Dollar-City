import 'package:flutter/material.dart';

import '../../data/models/market_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Clean left-image / right-info marketplace listing row.
class MarketplaceListItem extends StatelessWidget {
  const MarketplaceListItem({super.key, required this.item, this.onTap});

  final MarketItem item;
  final VoidCallback? onTap;

  static const double imageSize = 112;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
        child: SizedBox(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ItemImage(url: item.imageUrl),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.listingTitle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatPosted(item.createdAt),
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(item.formattedPrice, style: AppTextStyles.price),
                        if (!item.isAvailable) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.chipBackground,
                              borderRadius: BorderRadius.circular(
                                AppRadius.small,
                              ),
                            ),
                            child: Text(
                              'Reserved',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            '${item.pickupArea} · ${item.distanceMiles.toStringAsFixed(1)} miles',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption,
                          ),
                        ),
                        const Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${item.favoriteCount}',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.visibility_outlined,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 3),
                        Text('${item.viewCount}', style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPosted(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }
}

class _ItemImage extends StatelessWidget {
  const _ItemImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.medium + 2),
      child: SizedBox(
        width: MarketplaceListItem.imageSize,
        height: MarketplaceListItem.imageSize,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const _ImageFallback(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const ColoredBox(
              color: AppColors.imageFallback,
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.imageFallback,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 36,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
