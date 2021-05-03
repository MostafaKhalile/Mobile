import 'dart:convert';

import 'package:techtime/Controllers/repositories/user/api_client.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/models/client_profile.dart';

class USerRepo {
  PreferenceUtils _prefs;
  ClientApiClient _apiClient;

  USerRepo() {
    _prefs = PreferenceUtils.getInstance();
    _apiClient = ClientApiClient(prefs: _prefs);
  }

  Future<ClientProfile> getProfileData() async {
    try {
      final dataResp = (await _apiClient.getProfileData());
      final data = json.decode(dataResp)['Data'] as Map;
      final ClientProfile profileData = ClientProfile.fromJson(data);
      if (data["status"] == 201) {
        print(profileData);
      } else {
        print(profileData);
      }
      return profileData;
    } catch (e) {
      print(e);
      final message = e;
      return Future.error(message);
    }
  }
}
