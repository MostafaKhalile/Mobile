import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/network_constents.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import '../../Auth/repository.dart';

class ClientApiClient {
  final PreferenceUtils prefs;
  final AuthRepo _authRepo = AuthRepo();

  ClientApiClient({
    @required this.prefs,
  }) : assert(prefs != null);
  Future getProfileData() async {
    final String _path = KAPIURL + NetworkConstants.userProfileAPI;

    try {
      var resp = await http.post(Uri.parse(_path),
          headers: {"Authorization": "Token $currentToken"});
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

  Future<bool> editFirstName(String name) async {
    final String _path = KAPIURL + NetworkConstants.editFirstName;

    try {
      var resp = await http.post(Uri.parse(_path),
          body: {"first_name": name, "LanguageCode": "AR"},
          headers: {"Authorization": "Token $currentToken"});
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        print("First Name has been edited $respData");
        return true;
      } else {
        print(
            "[Edit User FirstName] status message: #${respData["status"]}, status code: #${respData["message"]}");
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e.bodyBytes))['message']);
    }
  }

  Future<bool> editSecondName(String name) async {
    final String _path = KAPIURL + NetworkConstants.editLastName;

    try {
      var resp = await http.post(Uri.parse(_path),
          body: {"last_name": name, "LanguageCode": "AR"},
          headers: {"Authorization": "Token $currentToken"});
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        print("First Name has been edited $respData");
        return true;
      } else {
        print(
            "[Edit User FirstName] status message: #${respData["status"]}, status code: #${respData["message"]}");
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e.bodyBytes))['message']);
    }
  }

  Future<bool> editEmailAddress(String email) async {
    final String _path = KAPIURL + NetworkConstants.editEmailAddress;

    try {
      var resp = await http.post(Uri.parse(_path),
          body: {"email": email, "LanguageCode": _authRepo.currentLanguageCode},
          headers: {"Authorization": "Token $currentToken"});
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        print("First Name has been edited $respData");
        return true;
      } else {
        print(
            "[Edit User FirstName] status message: #${respData["status"]}, status code: #${respData["message"]}");
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e.bodyBytes))['message']);
    }
  }

  void logOut() {}
  String get currentToken {
    return _authRepo.currentUserToken;
  }
}
