import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Reusable Dollar City marketplace post row.
///
/// Layout: square image left, title / time / fixed \$1 / views on the right.
/// Always displays exactly \$1 — price is not editable.
class MarketplacePostTile extends StatelessWidget {
  const MarketplacePostTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.postedTime,
    required this.viewCount,
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final String postedTime;
  final int viewCount;
  final VoidCallback? onTap;

  static const double _imageSize = 116;
  static const double _minHeight = 148;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: _minHeight),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PostImage(url: imageUrl),
                      const SizedBox(width: 14),
                      Expanded(
                        child: SizedBox(
                          height: _minHeight - 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                postedTime,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '\$1',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '$viewCount views',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.divider),
          ],
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: MarketplacePostTile._imageSize,
        height: MarketplacePostTile._imageSize,
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
