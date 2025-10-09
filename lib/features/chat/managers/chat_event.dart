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