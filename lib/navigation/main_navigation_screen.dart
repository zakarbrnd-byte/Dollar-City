import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/messages/presentation/messages_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/sell/presentation/sell_screen.dart';
import 'navigation_provider.dart';

/// Root shell with fixed bottom navigation and emphasized Sell action.
class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  static const _screens = [
    HomeScreen(),
    SellScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 72,
            child: Row(
              children: [
                _NavItem(
                  label: 'Home',
                  icon: Icons.storefront_outlined,
                  selectedIcon: Icons.storefront,
                  selected: selectedIndex == 0,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 0,
                ),
                _SellNavItem(
                  selected: selectedIndex == 1,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 1,
                ),
                _NavItem(
                  label: 'Messages',
                  icon: Icons.chat_bubble_outline,
                  selectedIcon: Icons.chat_bubble,
                  selected: selectedIndex == 2,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 2,
                ),
                _NavItem(
                  label: 'Profile',
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  selected: selectedIndex == 3,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selected ? selectedIcon : icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.navLabel.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _SellNavItem extends StatelessWidget {
  const _SellNavItem({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -6),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.softGold,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkGreen.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: selected ? Colors.white : AppColors.darkGreen,
                  size: 28,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -4),
              child: Text(
                'Sell',
                style: AppTextStyles.navLabel.copyWith(
                  color: selected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
