import 'dart:convert';

import 'package:techtime/Helpers/network_constents.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/Models/client_profile.dart';

import 'api_client.dart';

class USerRepo {
  PreferenceUtils _prefs;
  AccountApiClient _apiClient;

  USerRepo() {
    _prefs = PreferenceUtils.getInstance();
    _apiClient = AccountApiClient(
      prefs: _prefs,
    );
  }

  Future<UserProfile> getProfileData() async {
    try {
      final dataResp = (await _apiClient.getProfileData());
      final data = json.decode(dataResp)['Data'] as Map;
      final UserProfile profileData = UserProfile.fromJson(data);
      if (json.decode(dataResp)['status'] == 201) {
        _saveCurrentUserProfile(profileData.toJson());
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
    if (hasEdited) await getProfileData();
    return hasEdited;
  }

  Future<bool> editSecondName(String name) async {
    final bool hasEdited = await _apiClient.editSecondName(name);
    if (hasEdited) await getProfileData();
    return hasEdited;
  }

  Future<bool> editEmailAddress(String email) async {
    final bool hasEdited = await _apiClient.editEmailAddress(email);
    if (hasEdited) await getProfileData();
    return hasEdited;
  }

  Future<bool> editMobile(String mobile) async {
    final bool hasEdited = await _apiClient.editMobile(mobile);
    if (hasEdited) await getProfileData();
    return hasEdited;
  }

  Future<bool> _saveCurrentUserProfile(Map<String, dynamic> userData) async {
    return _prefs.saveValueWithKey<String>(
        NetworkConstants.currentUserProfile, jsonEncode(userData));
  }
}
