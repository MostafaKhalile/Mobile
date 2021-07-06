import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';
import 'package:http/http.dart' as http;

class NotificatiosApiClient {
  final AuthRepo _authRepo = AuthRepo();

  Future<AllNotifications> getUserNotifications() async {
    final String path =
        NetworkConstants.baseUrl + NetworkConstants.allUserNotification;
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${_authRepo.currentUserToken}"
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;

      return AllNotifications.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }
}
