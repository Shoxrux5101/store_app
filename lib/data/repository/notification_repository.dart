import 'package:store_app/core/network/api_client.dart';
import 'package:store_app/data/models/notification_model.dart';
import '../../core/utils/result.dart';

class NotificationRepository {
  final ApiClient _apiClient;

  NotificationRepository({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<Result<List<NotificationModel>>> getNotification() async {
    final response = await _apiClient.get('/notifications/list');

    return response.fold(
          (error) => Result.error(error),
          (success) {
        final List<dynamic> data = success as List<dynamic>;
        final notifications = data
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.ok(notifications);
      },
    );
  }
}

