import 'package:techtime/Models/notifications/all_notifications.dart';

import 'api_client.dart';

class NotificationsRepo {
  NotificatiosApiClient _apiClient;

  Future<AllNotifications> getUserNotifications() async {
    final userNotifications = await _apiClient.getUserNotifications();

    return userNotifications;
  }
}
