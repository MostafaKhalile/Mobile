import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';
import 'package:http/http.dart' as http;

class NotificatiosApiClient {
  // final AuthRepo _authRepo = AuthRepo();
  final headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json",
    "Authorization": "Token ${AuthRepo().currentUserToken}"
  };

  Future<AllNotifications> getUserNotifications() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.allUserNotification;
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;

      return AllNotifications.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<bool> readAllNotifications() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.readAllUserNotifications;
    final response = await http.post(Uri.parse(path), headers: headers);
    final decoded = utf8.decode(response.bodyBytes);
    final data = json.decode(decoded) as Map<String, dynamic>;
    if (data['status'] == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> clearAllNotifications() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.clearAllUserNotifications;
    final response = await http.post(Uri.parse(path), headers: headers);
    final decoded = utf8.decode(response.bodyBytes);
    final data = json.decode(decoded) as Map<String, dynamic>;
    if (data['status'] == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteNotification(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.deleteUserNotification +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: headers);
    final decoded = utf8.decode(response.bodyBytes);
    final data = json.decode(decoded) as Map<String, dynamic>;
    if (data['status'] == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> readNotification(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.readUserNotification +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: headers);
    final decoded = utf8.decode(response.bodyBytes);
    final data = json.decode(decoded) as Map<String, dynamic>;
    if (data['status'] == 201) {
      return true;
    } else {
      return false;
    }
  }
}
