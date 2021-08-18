import 'dart:async';
import 'dart:convert';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Controllers/Repositories/Auth/api_client.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/Models/user.dart';

class AuthRepo {
  late PreferenceUtils _prefs;
  late AuthApiClient _apiClient;

  AuthRepo() {
    _prefs = PreferenceUtils.getInstance();
    _apiClient = AuthApiClient(prefs: _prefs);
  }

  Future<User> loginUser(String email, String password, String fcmToken) async {
    try {
      final dataResp = await _apiClient.loginUser(
          email: email, password: password, fcmToken: fcmToken);
      final data = json.decode(dataResp.toString()) as Map<String, dynamic>;
      final User user = User.fromJson(data);
      if (data["status"] == 201) {
        _saveUserToken(user.token);
        _saveCurrentUser(user.toJson());
        await USerRepo().getProfileData();
        return user;
      } else {
        return Future.error(data["message"] as Object);
      }
    } catch (e) {
      final message = e;
      return Future.error(message);
    }
  }

  Future<bool> logout() async {
    try {
      {
        await _removeUserLocalData();
        return true;
      }
    } catch (e) {
      // final message = e["message"];
      return Future.error("message");
    }
  }

  String? get currentUserToken {
    final String userResp = _prefs
        .getValueWithKey(NetworkConstants.currentUserToken,
            hideDebugPrint: true)
        .toString();

    return userResp;
  }

  String get currentLanguageCode {
    final userLanguage = _prefs
        .getValueWithKey(
          'language_code',
        )
        .toString();

    return userLanguage.toUpperCase();
  }

  User? get currentUser {
    final userResp = _prefs.getValueWithKey(NetworkConstants.currentUser,
        hideDebugPrint: true);
    if (userResp == null) {
      return null;
    }

    return User.fromJson(
        json.decode(userResp.toString()) as Map<String, dynamic>);
  }

  Future<void> _removeUserLocalData() async {
    try {
      _prefs.removeMultipleValuesWithKeys([
        NetworkConstants.currentUser,
        NetworkConstants.currentUserToken,
        NetworkConstants.currentUserProfile,
      ]);
      // ignore: empty_catches
    } catch (e) {}
  }

  UserRole? get userType {
    UserRole? role;
    if (currentUser != null) {
      if (currentUser!.accountTypeUser == 3) {
        role = UserRole.company;
      } else if (currentUser!.accountTypeUser == 4) {
        role = UserRole.client;
      } else {
        role = UserRole.guest;
      }
    }
    return role;
  }

  Future<bool> _saveUserToken(String? token) async {
    return _prefs.saveValueWithKey<String?>(
        NetworkConstants.currentUserToken, token);
  }

  Future<bool> _saveCurrentUser(Map<String, dynamic> user) async {
    return _prefs.saveValueWithKey<String>(
        NetworkConstants.currentUser, jsonEncode(user));
  }
}
