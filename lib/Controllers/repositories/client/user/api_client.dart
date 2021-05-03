import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/network_constents.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';

class ClientApiClient {
  final PreferenceUtils prefs;

  ClientApiClient({
    @required this.prefs,
  }) : assert(prefs != null);
  Future getProfileData() async {
    final String _path = KAPIURL + NetworkConstants.userProfileAPI;

    try {
      var resp = await http.post(Uri.parse(_path),
          headers: {"Authorization": "Token ${AuthRepo().currentUserToken}"});
      final decoded = utf8.decode(resp.bodyBytes);
      print(
          "[Login User] status message: #${resp.statusCode}, status code: #${resp.statusCode}");
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
