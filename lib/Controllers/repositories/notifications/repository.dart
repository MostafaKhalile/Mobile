import 'package:techtime/Models/notifications/all_notifications.dart';

import 'api_client.dart';

class NotificationsRepo {
  final NotificatiosApiClient _apiClient = NotificatiosApiClient();

  Future<AllNotifications> getUserNotifications() async {
    final userNotifications = await _apiClient.getUserNotifications();

    return userNotifications;
  }
}
