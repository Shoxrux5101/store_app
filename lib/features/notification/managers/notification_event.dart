part of 'notification_bloc.dart';

sealed class NotificationEvent {}

final class NotificationEventFetch extends NotificationEvent {}

final class NotificationEventFetchWithParams extends NotificationEvent {
  final int id;

  NotificationEventFetchWithParams({required this.id});
}