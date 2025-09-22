import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/notification_model.dart';
part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  factory NotificationState({
    required List<NotificationModel> notifications,
    required bool isLoading,
    String? error,
    int? id,
  }) = _NotificationState;

  factory NotificationState.initial() => NotificationState(
    notifications: [],
    isLoading: false,
    error: null,
    id: null,
  );
}
