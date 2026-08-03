import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final urls = widget.imageUrls;
    final height = MediaQuery.sizeOf(context).width.clamp(300, 360).toDouble();

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (urls.isEmpty)
            const _GalleryFallback()
          else
            PageView.builder(
              itemCount: urls.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) {
                return Image.network(
                  urls[index],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const _GalleryFallback(),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const ColoredBox(
                      color: AppColors.imageFallback,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                );
              },
            ),
          if (urls.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(urls.length, (i) {
                  final active = i == _index;
                  return Container(
                    width: active ? 8 : 6,
                    height: active ? 8 : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _GalleryFallback extends StatelessWidget {
  const _GalleryFallback();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.imageFallback,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 56,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
