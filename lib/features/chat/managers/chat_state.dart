import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_state.freezed.dart';

enum Status { initial, loading, success, error}

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState ({required Status status, required List<Map<String, dynamic>> messages}) = _ChatState;

  factory ChatState.initial() {
    return ChatState(status: Status.initial, messages: []);
  }

}