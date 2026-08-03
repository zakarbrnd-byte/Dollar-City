import 'chat_message.dart';

class ChatConversation {
  const ChatConversation({
    required this.id,
    required this.userId,
    required this.userName,
    required this.itemTitle,
    required this.lastMessage,
    required this.lastMessageTime,
    this.avatarUrl,
    this.messages = const [],
  });

  final String id;
  final String userId;
  final String userName;
  final String itemTitle;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String? avatarUrl;
  final List<ChatMessage> messages;

  ChatConversation copyWith({
    String? id,
    String? userId,
    String? userName,
    String? itemTitle,
    String? lastMessage,
    DateTime? lastMessageTime,
    String? avatarUrl,
    List<ChatMessage>? messages,
  }) {
    return ChatConversation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      itemTitle: itemTitle ?? this.itemTitle,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      messages: messages ?? this.messages,
    );
  }
}
