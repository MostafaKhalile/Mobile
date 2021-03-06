import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/Models/client/wallet/wallet_points_to_price.dart';
import 'package:techtime/Models/client/wallet/wallet_total_data.dart';
import 'package:techtime/Models/client_profile.dart';

import 'api_client.dart';

class USerRepo {
  late PreferenceUtils _prefs;
  late AccountApiClient _apiClient;

  USerRepo() {
    _prefs = PreferenceUtils.getInstance();
    _apiClient = AccountApiClient(
      prefs: _prefs,
    );
  }
  UserProfile? get currentUserProfile {
    final userResp = _prefs.getValueWithKey(
      NetworkConstants.currentUserProfile,
    );
    if (userResp == null) {
      return null;
    }

    return UserProfile.fromJson(
        jsonDecode(userResp.toString()) as Map<String, dynamic>);
  }

  FutureOr<UserProfile> getProfileData() async {
    try {
      final dataResp = await _apiClient.getProfileData();
      final data =
          json.decode(dataResp.toString())['Data'] as Map<String, dynamic>;
      final UserProfile profileData = UserProfile.fromJson(data);
      if (json.decode(dataResp.toString())['status'] == 201) {
        _saveCurrentUserProfile(profileData.toJson());
        return profileData;
      } else {
        return Future.error(dataResp.toString());
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

  Future<bool> editPassword(Map<String, String> data) async {
    final bool hasEdited = await _apiClient.editPassword(data);
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
    return hasBeenUploaded;
  }

  Future<bool> uploadCover(File imageFile) async {
    final bool hasBeenUploaded = await _apiClient.uploadCover(imageFile);
    if (hasBeenUploaded) {
      await getProfileData();
    }

    return hasBeenUploaded;
  }

  Future<WalletTotalData> getWalletTotalData() async {
    final walletTotalData = await _apiClient.getWalletTotalData();
    return walletTotalData;
  }

  Future<WalletPointsToPrice> walletPointsToPrice(String points) async {
    final walletTotalData = await _apiClient.walletPointsToPrice(points);
    return walletTotalData;
  }

  Future<Map<String, dynamic>> walletTransformPoints(String points) async {
    final Map<String, dynamic> walletTotalData =
        await _apiClient.walletTransformPoints(points) as Map<String, dynamic>;
    return walletTotalData;
  }

  Future<Map<String, dynamic>> walletTransformPromocode(
      String promocode) async {
    final Map<String, dynamic> walletTotalData =
        await _apiClient.walletTransformPromocode(promocode);
    return walletTotalData;
  }

  Future<bool> _saveCurrentUserProfile(Map<String, dynamic> userData) async {
    return _prefs.saveValueWithKey<String>(
        NetworkConstants.currentUserProfile, jsonEncode(userData));
  }
}
