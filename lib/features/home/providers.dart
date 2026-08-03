import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/app_user.dart';
import '../../data/models/chat_conversation.dart';
import '../../data/models/chat_message.dart';
import '../../data/models/item_category.dart';
import '../../data/models/listing_status.dart';
import '../../data/models/market_item.dart';

/// Current bottom navigation tab index.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// Selected marketplace category filter.
final selectedCategoryProvider = StateProvider<ItemCategory>(
  (ref) => ItemCategory.all,
);

/// Current signed-in mock user.
final currentUserProvider = Provider<AppUser>((ref) => MockData.currentUser);

/// Marketplace items held in memory.
class MarketplaceItemsNotifier extends Notifier<List<MarketItem>> {
  @override
  List<MarketItem> build() => MockData.initialItems();

  void addItem(MarketItem item) {
    state = [item, ...state];
  }

  void toggleSaved(String itemId) {
    state = [
      for (final item in state)
        if (item.id == itemId) item.copyWith(isSaved: !item.isSaved) else item,
    ];
  }

  void updateStatus(String itemId, ListingStatus status) {
    state = [
      for (final item in state)
        if (item.id == itemId) item.copyWith(status: status) else item,
    ];
  }

  MarketItem? byId(String id) {
    for (final item in state) {
      if (item.id == id) return item;
    }
    return null;
  }
}

final marketplaceItemsProvider =
    NotifierProvider<MarketplaceItemsNotifier, List<MarketItem>>(
      MarketplaceItemsNotifier.new,
    );

/// Items filtered by selected category.
final filteredItemsProvider = Provider<List<MarketItem>>((ref) {
  final items = ref.watch(marketplaceItemsProvider);
  final category = ref.watch(selectedCategoryProvider);
  if (category == ItemCategory.all) return items;
  return items.where((item) => item.category == category).toList();
});

/// Saved items only.
final savedItemsProvider = Provider<List<MarketItem>>((ref) {
  return ref
      .watch(marketplaceItemsProvider)
      .where((item) => item.isSaved)
      .toList();
});

/// Listings owned by the current user.
final myListingsProvider = Provider<List<MarketItem>>((ref) {
  final userId = ref.watch(currentUserProvider).id;
  return ref
      .watch(marketplaceItemsProvider)
      .where((item) => item.sellerId == userId)
      .toList();
});

final myActiveListingsProvider = Provider<List<MarketItem>>((ref) {
  return ref
      .watch(myListingsProvider)
      .where((item) => item.status == ListingStatus.available)
      .toList();
});

final myReservedListingsProvider = Provider<List<MarketItem>>((ref) {
  return ref
      .watch(myListingsProvider)
      .where((item) => item.status == ListingStatus.reserved)
      .toList();
});

final mySoldListingsProvider = Provider<List<MarketItem>>((ref) {
  return ref
      .watch(myListingsProvider)
      .where((item) => item.status == ListingStatus.sold)
      .toList();
});

/// Chat conversations held in memory.
class ConversationsNotifier extends Notifier<List<ChatConversation>> {
  @override
  List<ChatConversation> build() => MockData.initialConversations();

  void sendMessage(String conversationId, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final now = DateTime.now();
    state = [
      for (final conversation in state)
        if (conversation.id == conversationId)
          conversation.copyWith(
            lastMessage: trimmed,
            lastMessageTime: now,
            messages: [
              ...conversation.messages,
              ChatMessage(
                id: 'msg_${now.millisecondsSinceEpoch}',
                conversationId: conversationId,
                senderId: MockData.currentUserId,
                text: trimmed,
                sentAt: now,
                isMine: true,
              ),
            ],
          )
        else
          conversation,
    ];
  }

  /// Opens an existing chat for an item/seller or creates a new empty one.
  String openOrCreateConversation({
    required String sellerId,
    required String sellerName,
    required String itemTitle,
    String? avatarUrl,
  }) {
    for (final conversation in state) {
      if (conversation.userId == sellerId &&
          conversation.itemTitle == itemTitle) {
        return conversation.id;
      }
    }

    final id = 'chat_${DateTime.now().millisecondsSinceEpoch}';
    final conversation = ChatConversation(
      id: id,
      userId: sellerId,
      userName: sellerName,
      itemTitle: itemTitle,
      lastMessage: 'Start the conversation',
      lastMessageTime: DateTime.now(),
      avatarUrl: avatarUrl,
      messages: const [],
    );
    state = [conversation, ...state];
    return id;
  }

  ChatConversation? byId(String id) {
    for (final conversation in state) {
      if (conversation.id == id) return conversation;
    }
    return null;
  }
}

final conversationsProvider =
    NotifierProvider<ConversationsNotifier, List<ChatConversation>>(
      ConversationsNotifier.new,
    );
