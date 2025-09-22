import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/repository/notification_repository.dart';
import 'notification_state.dart';

part 'notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc(this.repository) : super(NotificationState.initial()) {
    on<NotificationEventFetch>(_onFetchNotifications);
    on<NotificationEventFetchWithParams>(_onFetchNotificationsWithParams);
  }

  Future<void> _onFetchNotifications(
      NotificationEventFetch event,
      Emitter<NotificationState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await repository.getNotification();

    result.fold(
          (error) {
        emit(state.copyWith(error: error.toString(), isLoading: false));
      },
          (data) {
        emit(state.copyWith(notifications: data, isLoading: false));
      },
    );
  }

  Future<void> _onFetchNotificationsWithParams(
      NotificationEventFetchWithParams event,
      Emitter<NotificationState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null, id: event.id));
    final result = await repository.getNotification();

    result.fold(
          (error) {
        emit(state.copyWith(error: error.toString(), isLoading: false));
      },
          (data) {
        final filtered = data.where((n) => n.id == event.id).toList();
        emit(state.copyWith(notifications: filtered, isLoading: false));
      },
    );
  }

  Map<DateTime, List<NotificationModel>> groupNotifications(
      List<NotificationModel> notifications) {
    final Map<DateTime, List<NotificationModel>> grouped = {};

    for (final notification in notifications) {
      final dateKey = DateTime(
        notification.date.year,
        notification.date.month,
        notification.date.day,
      );

      grouped.putIfAbsent(dateKey, () => []).add(notification);
    }
    return grouped;
  }
}
