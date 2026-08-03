import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/empty_state.dart';
import '../home/providers.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.conversationId,
    this.titleOverride,
    this.subtitleOverride,
  });

  final String conversationId;
  final String? titleOverride;
  final String? subtitleOverride;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  static const _quickReplies = [
    'Is this still available?',
    'When can I pick it up?',
    'What area are you located in?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send([String? text]) {
    final value = (text ?? _controller.text).trim();
    if (value.isEmpty) return;

    ref
        .read(conversationsProvider.notifier)
        .sendMessage(widget.conversationId, value);
    _controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final conversations = ref.watch(conversationsProvider);
    final conversation = ref
        .read(conversationsProvider.notifier)
        .byId(widget.conversationId);

    // Re-resolve from watched list so UI rebuilds on new messages.
    final live = conversations
        .where((c) => c.id == widget.conversationId)
        .toList();
    final current = live.isEmpty ? conversation : live.first;

    if (current == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: const EmptyState(
          title: 'Conversation not found',
          icon: Icons.chat_bubble_outline,
        ),
      );
    }

    final theme = Theme.of(context);
    final title = widget.titleOverride ?? current.userName;
    final subtitle = widget.subtitleOverride ?? current.itemTitle;
    final messages = current.messages;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const EmptyState(
                    title: 'Say hello',
                    message: 'Ask about pickup timing or availability.',
                    icon: Icons.forum_outlined,
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMine = message.isMine;
                      return Align(
                        alignment: isMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                          ),
                          decoration: BoxDecoration(
                            color: isMine
                                ? theme.colorScheme.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: isMine
                                ? null
                                : Border.all(
                                    color: Colors.black.withValues(alpha: 0.06),
                                  ),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isMine
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                for (final reply in _quickReplies) ...[
                  ActionChip(
                    label: Text(reply),
                    onPressed: () => _send(reply),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Write a message…',
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
