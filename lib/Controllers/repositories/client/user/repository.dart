import 'dart:convert';

import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/models/client_profile.dart';

import 'api_client.dart';

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
}
