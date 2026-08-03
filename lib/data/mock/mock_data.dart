import '../models/app_user.dart';
import '../models/chat_conversation.dart';
import '../models/chat_message.dart';
import '../models/item_category.dart';
import '../models/item_condition.dart';
import '../models/listing_status.dart';
import '../models/market_item.dart';

/// Local mock data only — no backend.
class MockData {
  MockData._();

  static const currentUserId = 'user_me';

  static const currentUser = AppUser(
    id: currentUserId,
    name: 'Alex Rivera',
    pickupArea: 'Downtown',
    avatarUrl: 'https://i.pravatar.cc/150?u=alex_rivera',
    rating: 4.9,
  );

  static const users = <AppUser>[
    currentUser,
    AppUser(
      id: 'user_1',
      name: 'Jordan Lee',
      pickupArea: 'Westside',
      avatarUrl: 'https://i.pravatar.cc/150?u=jordan_lee',
      rating: 4.7,
    ),
    AppUser(
      id: 'user_2',
      name: 'Sam Okonkwo',
      pickupArea: 'Midtown',
      avatarUrl: 'https://i.pravatar.cc/150?u=sam_okonkwo',
      rating: 4.8,
    ),
    AppUser(
      id: 'user_3',
      name: 'Casey Nguyen',
      pickupArea: 'North End',
      avatarUrl: 'https://i.pravatar.cc/150?u=casey_nguyen',
      rating: 4.6,
    ),
    AppUser(
      id: 'user_4',
      name: 'Riley Patel',
      pickupArea: 'Eastside',
      avatarUrl: 'https://i.pravatar.cc/150?u=riley_patel',
      rating: 5.0,
    ),
    AppUser(
      id: 'user_5',
      name: 'Morgan Blake',
      pickupArea: 'Riverside',
      avatarUrl: 'https://i.pravatar.cc/150?u=morgan_blake',
      rating: 4.5,
    ),
  ];

  static AppUser userById(String id) {
    return users.firstWhere((u) => u.id == id, orElse: () => currentUser);
  }

  static List<MarketItem> initialItems() {
    final now = DateTime.now();
    return [
      MarketItem(
        id: 'item_1',
        sellerId: 'user_1',
        title: 'Wooden Side Table',
        description:
            'Small wooden side table in good condition. Some light wear on the top. '
            'Pickup only near Koreatown.',
        imageUrls: const [
          'https://picsum.photos/seed/woodtable/800/600',
          'https://picsum.photos/seed/woodtable2/800/600',
        ],
        category: ItemCategory.furniture,
        condition: ItemCondition.good,
        status: ListingStatus.available,
        pickupArea: 'Koreatown',
        distanceMiles: 1.2,
        createdAt: now.subtract(const Duration(minutes: 12)),
        viewCount: 28,
      ),
      MarketItem(
        id: 'item_2',
        sellerId: 'user_2',
        title: 'Baby stroller',
        description:
            'Lightweight umbrella stroller. Folds easily and has a sun canopy. '
            'Cleaned thoroughly. Pickup only near Midtown park.',
        imageUrls: const ['https://picsum.photos/seed/stroller/800/600'],
        category: ItemCategory.kids,
        condition: ItemCondition.good,
        status: ListingStatus.available,
        pickupArea: 'Midtown',
        distanceMiles: 2.4,
        createdAt: now.subtract(const Duration(minutes: 35)),
        isSaved: true,
        viewCount: 33,
      ),
      MarketItem(
        id: 'item_3',
        sellerId: 'user_3',
        title: 'Coffee maker',
        description:
            '12-cup drip coffee maker. Works great. Includes carafe and filter basket.',
        imageUrls: const ['https://picsum.photos/seed/coffee/800/600'],
        category: ItemCategory.home,
        condition: ItemCondition.likeNew,
        status: ListingStatus.available,
        pickupArea: 'Downtown LA',
        distanceMiles: 2.4,
        createdAt: now.subtract(const Duration(minutes: 12)),
        viewCount: 45,
      ),
      MarketItem(
        id: 'item_4',
        sellerId: 'user_4',
        title: 'Denim jacket',
        description:
            'Classic medium-wash denim jacket, size M. Softened from wear, no holes.',
        imageUrls: const ['https://picsum.photos/seed/jacket/800/600'],
        category: ItemCategory.clothing,
        condition: ItemCondition.good,
        status: ListingStatus.reserved,
        pickupArea: 'Eastside',
        distanceMiles: 0.8,
        createdAt: now.subtract(const Duration(hours: 1)),
        viewCount: 19,
      ),
      MarketItem(
        id: 'item_5',
        sellerId: currentUserId,
        title: 'Floor lamp',
        description:
            'Tall standing floor lamp with soft white shade. Bulb included. '
            'Slight scuff on the base.',
        imageUrls: const ['https://picsum.photos/seed/lamp/800/600'],
        category: ItemCategory.home,
        condition: ItemCondition.fair,
        status: ListingStatus.available,
        pickupArea: 'Downtown',
        distanceMiles: 0.3,
        createdAt: now.subtract(const Duration(hours: 2)),
        viewCount: 41,
      ),
      MarketItem(
        id: 'item_6',
        sellerId: 'user_5',
        title: 'Children’s books',
        description:
            'Bundle of 12 gently used picture books. Great for ages 2–6. '
            'No torn pages.',
        imageUrls: const ['https://picsum.photos/seed/books/800/600'],
        category: ItemCategory.kids,
        condition: ItemCondition.good,
        status: ListingStatus.available,
        pickupArea: 'Riverside',
        distanceMiles: 4.0,
        createdAt: now.subtract(const Duration(hours: 3)),
        isSaved: true,
        viewCount: 22,
      ),
      MarketItem(
        id: 'item_7',
        sellerId: 'user_1',
        title: 'Office chair',
        description:
            'Rolling office chair with adjustable height. Seat cushion is still firm.',
        imageUrls: const ['https://picsum.photos/seed/chair/800/600'],
        category: ItemCategory.furniture,
        condition: ItemCondition.used,
        status: ListingStatus.sold,
        pickupArea: 'Westside',
        distanceMiles: 1.5,
        createdAt: now.subtract(const Duration(hours: 5)),
        viewCount: 52,
      ),
      MarketItem(
        id: 'item_8',
        sellerId: currentUserId,
        title: 'Rice cooker',
        description:
            '3-cup rice cooker. Simple one-button operation. Clean and ready to use.',
        imageUrls: const ['https://picsum.photos/seed/ricecooker/800/600'],
        category: ItemCategory.home,
        condition: ItemCondition.likeNew,
        status: ListingStatus.reserved,
        pickupArea: 'Downtown',
        distanceMiles: 0.5,
        createdAt: now.subtract(const Duration(hours: 6)),
        viewCount: 17,
      ),
      MarketItem(
        id: 'item_9',
        sellerId: 'user_2',
        title: 'Bluetooth speaker',
        description:
            'Portable Bluetooth speaker with clear sound. Battery holds a charge. '
            'Small scuff on the side.',
        imageUrls: const ['https://picsum.photos/seed/speaker/800/600'],
        category: ItemCategory.electronics,
        condition: ItemCondition.good,
        status: ListingStatus.available,
        pickupArea: 'Midtown',
        distanceMiles: 2.0,
        createdAt: now.subtract(const Duration(hours: 9)),
        viewCount: 36,
      ),
      MarketItem(
        id: 'item_10',
        sellerId: 'user_3',
        title: 'Storage bins',
        description:
            'Set of 4 clear plastic storage bins with lids. Stackable and clean.',
        imageUrls: const ['https://picsum.photos/seed/bins/800/600'],
        category: ItemCategory.other,
        condition: ItemCondition.likeNew,
        status: ListingStatus.available,
        pickupArea: 'North End',
        distanceMiles: 2.8,
        createdAt: now.subtract(const Duration(hours: 11)),
        viewCount: 14,
      ),
      MarketItem(
        id: 'item_11',
        sellerId: currentUserId,
        title: 'Kitchen stool',
        description:
            'Wooden counter-height stool. Solid and stable. Minor wear on seat.',
        imageUrls: const ['https://picsum.photos/seed/stool/800/600'],
        category: ItemCategory.furniture,
        condition: ItemCondition.good,
        status: ListingStatus.sold,
        pickupArea: 'Downtown',
        distanceMiles: 0.4,
        createdAt: now.subtract(const Duration(days: 1)),
        viewCount: 9,
      ),
    ];
  }

  static List<ChatConversation> initialConversations() {
    final now = DateTime.now();
    return [
      ChatConversation(
        id: 'chat_1',
        userId: 'user_2',
        userName: 'Sam Okonkwo',
        itemTitle: 'Floor lamp',
        lastMessage: 'I can pick it up after 6pm.',
        lastMessageTime: now.subtract(const Duration(minutes: 12)),
        avatarUrl: 'https://i.pravatar.cc/150?u=sam_okonkwo',
        messages: [
          ChatMessage(
            id: 'msg_1_1',
            conversationId: 'chat_1',
            senderId: 'user_2',
            text: 'Hi! Is the floor lamp still available?',
            sentAt: now.subtract(const Duration(hours: 2)),
          ),
          ChatMessage(
            id: 'msg_1_2',
            conversationId: 'chat_1',
            senderId: currentUserId,
            text: 'Yes, it is! Pickup near Downtown.',
            sentAt: now.subtract(const Duration(hours: 1, minutes: 45)),
            isMine: true,
          ),
          ChatMessage(
            id: 'msg_1_3',
            conversationId: 'chat_1',
            senderId: 'user_2',
            text: 'Great. When can I pick it up?',
            sentAt: now.subtract(const Duration(minutes: 30)),
          ),
          ChatMessage(
            id: 'msg_1_4',
            conversationId: 'chat_1',
            senderId: currentUserId,
            text: 'Anytime after 5 works for me.',
            sentAt: now.subtract(const Duration(minutes: 20)),
            isMine: true,
          ),
          ChatMessage(
            id: 'msg_1_5',
            conversationId: 'chat_1',
            senderId: 'user_2',
            text: 'I can pick it up after 6pm.',
            sentAt: now.subtract(const Duration(minutes: 12)),
          ),
        ],
      ),
      ChatConversation(
        id: 'chat_2',
        userId: 'user_4',
        userName: 'Riley Patel',
        itemTitle: 'Rice cooker',
        lastMessage: 'Perfect, see you Saturday.',
        lastMessageTime: now.subtract(const Duration(hours: 3)),
        avatarUrl: 'https://i.pravatar.cc/150?u=riley_patel',
        messages: [
          ChatMessage(
            id: 'msg_2_1',
            conversationId: 'chat_2',
            senderId: 'user_4',
            text: 'Is this still available?',
            sentAt: now.subtract(const Duration(hours: 5)),
          ),
          ChatMessage(
            id: 'msg_2_2',
            conversationId: 'chat_2',
            senderId: currentUserId,
            text: 'Yes — I reserved it for you.',
            sentAt: now.subtract(const Duration(hours: 4, minutes: 30)),
            isMine: true,
          ),
          ChatMessage(
            id: 'msg_2_3',
            conversationId: 'chat_2',
            senderId: 'user_4',
            text: 'What area are you located in?',
            sentAt: now.subtract(const Duration(hours: 4)),
          ),
          ChatMessage(
            id: 'msg_2_4',
            conversationId: 'chat_2',
            senderId: currentUserId,
            text:
                'Downtown area — I will share the exact spot when you are close.',
            sentAt: now.subtract(const Duration(hours: 3, minutes: 30)),
            isMine: true,
          ),
          ChatMessage(
            id: 'msg_2_5',
            conversationId: 'chat_2',
            senderId: 'user_4',
            text: 'Perfect, see you Saturday.',
            sentAt: now.subtract(const Duration(hours: 3)),
          ),
        ],
      ),
      ChatConversation(
        id: 'chat_3',
        userId: 'user_1',
        userName: 'Jordan Lee',
        itemTitle: 'Small desk',
        lastMessage: 'Thanks for asking!',
        lastMessageTime: now.subtract(const Duration(days: 1)),
        avatarUrl: 'https://i.pravatar.cc/150?u=jordan_lee',
        messages: [
          ChatMessage(
            id: 'msg_3_1',
            conversationId: 'chat_3',
            senderId: currentUserId,
            text: 'Is this still available?',
            sentAt: now.subtract(const Duration(days: 1, hours: 2)),
            isMine: true,
          ),
          ChatMessage(
            id: 'msg_3_2',
            conversationId: 'chat_3',
            senderId: 'user_1',
            text: 'Yes it is! Happy to meet near Westside.',
            sentAt: now.subtract(const Duration(days: 1, hours: 1)),
          ),
          ChatMessage(
            id: 'msg_3_3',
            conversationId: 'chat_3',
            senderId: currentUserId,
            text: 'Thanks for asking!',
            sentAt: now.subtract(const Duration(days: 1)),
            isMine: true,
          ),
        ],
      ),
    ];
  }
}
