import 'dart:convert';
import 'dart:io';

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
  UserProfile get currentUserProfile {
    final userResp = _prefs.getValueWithKey(NetworkConstants.currentUserProfile,
        hideDebugPrint: true);
    if (userResp == null) {
      return null;
    }
    print(UserProfile.fromJson(jsonDecode(userResp)).toString());
    return UserProfile.fromJson(jsonDecode(userResp));
  }

  Future getProfileData() async {
    try {
      final dataResp = (await _apiClient.getProfileData());
      final data = json.decode(dataResp)['Data'] as Map;
      final UserProfile profileData = UserProfile.fromJson(data);
      if (json.decode(dataResp)['status'] == 201) {
        _saveCurrentUserProfile(profileData.toJson());
        return profileData;
      } else {
        return Future.error(json.decode(dataResp));
      }
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

  Future<bool> uploadProfilePicture(File imageFile) async {
    final bool hasBeenUploaded =
        await _apiClient.uploadProfilePicture(imageFile);
    if (hasBeenUploaded) {
      await getProfileData();
    }
    print("[Upload Profile Picture Repository] $hasBeenUploaded");
    return hasBeenUploaded;
  }

  Future<bool> _saveCurrentUserProfile(Map<String, dynamic> userData) async {
    return _prefs.saveValueWithKey<String>(
        NetworkConstants.currentUserProfile, jsonEncode(userData));
  }
}
