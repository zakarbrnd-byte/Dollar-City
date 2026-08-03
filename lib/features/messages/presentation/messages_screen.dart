import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/empty_state.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Messages')),
      body: SafeArea(
        child: EmptyState(
          icon: Icons.chat_bubble_outline,
          title: 'Messages',
          description:
              'Pickup conversations with buyers and sellers will appear here.',
          child: Text(
            'No conversations yet.',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
