import 'dart:convert';

import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/models/client_profile.dart';

import 'api_client.dart';

class USerRepo {
  PreferenceUtils _prefs;
  ClientApiClient _apiClient;

  USerRepo() {
    _prefs = PreferenceUtils.getInstance();
    _apiClient = ClientApiClient(
      prefs: _prefs,
    );
  }

  Future<USerProfile> getProfileData() async {
    try {
      final dataResp = (await _apiClient.getProfileData());
      final data = json.decode(dataResp)['Data'] as Map;
      final USerProfile profileData = USerProfile.fromJson(data);
      if (json.decode(dataResp)['status'] == 201) {
      } else {
        return Future.error(json.decode(dataResp));
      }
      return profileData;
    } catch (e) {
      final message = e;
      return Future.error(message);
    }
  }

  Future<bool> editFirstName(String name) async {
    final bool hasEdited = await _apiClient.editFirstName(name);
    return hasEdited;
  }

  Future<bool> editSecondName(String name) async {
    final bool hasEdited = await _apiClient.editSecondName(name);
    return hasEdited;
  }

  Future<bool> editEmailAddress(String email) async {
    final bool hasEdited = await _apiClient.editEmailAddress(email);
    return hasEdited;
  }
}
