import 'dart:async';
import 'dart:convert';

import 'package:techtime/Controllers/repositories/Auth/api_client.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/network_constents.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/models/user.dart';

//? Login  -> (registered)  -> check code -> home Screen
//?        -> (Not registered) -> register > check code -> home screen
//
//? logout -> login screen

class AuthRepo {
  PreferenceUtils _prefs;
  AuthApiClient _apiClient;
  User _user;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  AuthRepo() {
    _prefs = PreferenceUtils.getInstance();
    _apiClient = AuthApiClient(prefs: _prefs);
  }

  Future<User> loginUser(String email, String password) async {
    try {
      final dataResp =
          (await _apiClient.loginUser(email: email, password: password));
      final data = json.decode(dataResp) as Map;
      final User user = User.fromJson(data);
      if (data["status"] == 201) {
        _saveUserToken(user.token);
        print(user.token);
      } else {
        print(user.message);
      }
      return user;
    } catch (e) {
      print(e);
      final message = e;
      return Future.error(message);
    }
  }

  String get currentUserToken {
    final userResp = _prefs.getValueWithKey(NetworkConstants.currentUserToken,
        hideDebugPrint: true);
    if (userResp == null) {
      return null;
    }
    return userResp;
  }

  Future<UserRole> userType() async {
    UserRole role;
    if (_user != null) {
      role = UserRole.client;
    }
    return role;
  }

  Future<bool> _saveUserToken(String token) async {
    return _prefs.saveValueWithKey<String>(
        NetworkConstants.currentUserToken, token);
  }

  void dispose() => _controller.close();
}
