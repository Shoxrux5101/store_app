import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/status.dart' as websocket_status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'chat_state.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatMessageSend>(_onMessageSend);
    _connect();
  }

  late final WebSocketChannel websocket;
  late final StreamSubscription subscription;

  Future<void> _connect() async {
    try {
      final uri = Uri.parse("ws://192.168.0.110:8888/chat");
      websocket = WebSocketChannel.connect(uri);

      subscription = websocket.stream.listen((message) {
        final msg = jsonDecode(message);
        add(ChatMessageReceived(message: msg));
      });
    } catch (e) {
      print("WebSocket connection error: $e");
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    websocket.sink.close(websocket_status.normalClosure, "Connection closed.");
    return super.close();
  }

  Future<void> _onMessageReceived(
      ChatMessageReceived event,
      Emitter<ChatState> emit,
      ) async {
    emit(state.copyWith(messages: [...state.messages, event.message]));
  }

  Future<void> _onMessageSend(
      ChatMessageSend event,
      Emitter<ChatState> emit,
      ) async {
    final message = {
      "message": event.message,
      "direction": "from",
      "date": DateTime.now().toIso8601String(),
    };
    websocket.sink.add(jsonEncode(message));
    emit(state.copyWith(messages: [...state.messages, message]));
  }
}
