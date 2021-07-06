import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:techtime/Helpers/api_urls.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';

class AuthApiClient {
  final PreferenceUtils prefs;

  AuthApiClient({
    @required this.prefs,
  }) : assert(prefs != null);
  Future loginUser({
    String email,
    String password,
    String fcmToken,
  }) async {
    final String _path = KAPIURL + KLoginPAth;
    final Map<String, dynamic> data = {
      "RequestType": "API",
      "LanguageCode": "EN",
      "username": email,
      "password": password,
      "RegistrationId": fcmToken
    };
    try {
      final resp = await http.post(
        Uri.parse(_path),
        body: data,
      );
      final decoded = utf8.decode(resp.bodyBytes);

      if (resp.statusCode == 200) {
        return decoded;
      } else {
        print(
            "[Login User] status message: #${resp.statusCode}, status code: #${resp.statusCode}");
        final data = resp.body;
        return Future.error(data);
      }
    } catch (e) {
      if (e.response != null) {
      } else {}
      return Future.error("error");
    }
  }

  void logOut() {}
}
