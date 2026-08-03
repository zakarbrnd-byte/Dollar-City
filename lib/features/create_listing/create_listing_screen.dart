import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/item_category.dart';
import '../../data/models/item_condition.dart';
import '../../data/models/listing_status.dart';
import '../../data/models/market_item.dart';
import '../home/providers.dart';

class CreateListingScreen extends ConsumerStatefulWidget {
  const CreateListingScreen({super.key});

  @override
  ConsumerState<CreateListingScreen> createState() =>
      _CreateListingScreenState();
}

class _CreateListingScreenState extends ConsumerState<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pickupAreaController = TextEditingController();

  ItemCategory? _category;
  ItemCondition? _condition;
  int _photoCount = 1;
  bool _submitting = false;
  int _formEpoch = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _pickupAreaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_category == null || _condition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a category and condition.'),
        ),
      );
      return;
    }

    setState(() => _submitting = true);

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final now = DateTime.now();
    final item = MarketItem(
      id: 'item_${now.millisecondsSinceEpoch}',
      sellerId: MockData.currentUserId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrls: List.generate(
        _photoCount,
        (index) =>
            'https://picsum.photos/seed/new_${now.millisecondsSinceEpoch}_$index/800/600',
      ),
      category: _category!,
      condition: _condition!,
      status: ListingStatus.available,
      pickupArea: _pickupAreaController.text.trim(),
      distanceMiles: 0.5,
      createdAt: now,
    );

    ref.read(marketplaceItemsProvider.notifier).addItem(item);
    ref.read(bottomNavIndexProvider.notifier).state = 0;

    if (!mounted) return;
    setState(() => _submitting = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Listing posted for \$1.')));

    _formKey.currentState!.reset();
    _titleController.clear();
    _descriptionController.clear();
    _pickupAreaController.clear();
    setState(() {
      _category = null;
      _condition = null;
      _photoCount = 1;
      _formEpoch++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sell')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.warmCream,
                borderRadius: BorderRadius.circular(AppRadius.medium),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                'All items on Dollar Market are listed for exactly \$1.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Photos (up to 4)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _photoCount < 4 ? _photoCount + 1 : _photoCount,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  if (index < _photoCount) {
                    return _PhotoPlaceholder(
                      label: 'Photo ${index + 1}',
                      onRemove: _photoCount > 1
                          ? () => setState(() => _photoCount -= 1)
                          : null,
                    );
                  }
                  return _AddPhotoTile(
                    onTap: () => setState(() => _photoCount += 1),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Item title',
                hintText: 'e.g. Small desk',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Condition, size, and pickup notes',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            FormField<ItemCategory>(
              key: ValueKey('category_$_formEpoch'),
              initialValue: _category,
              validator: (value) =>
                  value == null ? 'Category is required' : null,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    errorText: field.errorText,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ItemCategory>(
                      isExpanded: true,
                      value: field.value,
                      hint: const Text('Select a category'),
                      items: [
                        for (final category in ItemCategory.listingValues)
                          DropdownMenuItem(
                            value: category,
                            child: Text(category.label),
                          ),
                      ],
                      onChanged: (value) {
                        field.didChange(value);
                        setState(() => _category = value);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            FormField<ItemCondition>(
              key: ValueKey('condition_$_formEpoch'),
              initialValue: _condition,
              validator: (value) =>
                  value == null ? 'Condition is required' : null,
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Condition',
                    errorText: field.errorText,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ItemCondition>(
                      isExpanded: true,
                      value: field.value,
                      hint: const Text('Select a condition'),
                      items: [
                        for (final condition in ItemCondition.values)
                          DropdownMenuItem(
                            value: condition,
                            child: Text(condition.label),
                          ),
                      ],
                      onChanged: (value) {
                        field.didChange(value);
                        setState(() => _condition = value);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _pickupAreaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Approximate pickup area',
                hintText: 'e.g. Downtown',
                helperText: 'Do not enter your exact street address.',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Pickup area is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Post for \$1',
              icon: Icons.check_circle_outline,
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder({required this.label, this.onRemove});

  final String label;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.image_outlined,
              size: 32,
              color: AppColors.textSecondary,
            ),
          ),
          Positioned(
            left: 6,
            bottom: 6,
            child: Text(label, style: Theme.of(context).textTheme.labelSmall),
          ),
          if (onRemove != null)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onRemove,
                icon: const Icon(Icons.close, size: 16),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        width: 96,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.4),
            style: BorderStyle.solid,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, color: AppColors.primary),
            SizedBox(height: 6),
            Text(
              'Add',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
