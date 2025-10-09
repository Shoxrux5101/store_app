part of 'chat_bloc.dart';

sealed class ChatEvents {}

final class ChatMessageSend extends ChatEvents {
  final String message;

   ChatMessageSend({required this.message});
}

final class ChatMessageReceived extends ChatEvents {
  final Map<String, dynamic> message;

  ChatMessageReceived({required this.message});
}
final class ChatMessageDelete extends ChatEvents {
  final int index;

  ChatMessageDelete({required this.index});
}
final class ChatMessageEdit extends ChatEvents {
  final int index;
  final String newMessage;

  ChatMessageEdit({required this.index, required this.newMessage});
}