import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/Models/client/wallet/wallet_points_to_price.dart';
import 'package:techtime/Models/client/wallet/wallet_total_data.dart';

class AccountApiClient {
  final PreferenceUtils prefs;
  final AuthRepo _authRepo = AuthRepo();

  AccountApiClient({
    @required this.prefs,
  }) : assert(prefs != null);
  Future getProfileData() async {
    const String _path =
        NetworkConstants.baseUrl + NetworkConstants.userProfileAPI;

    try {
      final resp = await http.post(Uri.parse(_path),
          headers: {"Authorization": "Token $currentToken"});
      final decoded = utf8.decode(resp.bodyBytes);

      if (resp.statusCode == 200) {
        return decoded;
      } else {
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
    const String _path =
        NetworkConstants.baseUrl + NetworkConstants.editFirstName;

    try {
      final resp = await http.post(Uri.parse(_path), body: {
        "first_name": name,
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        return true;
      } else {
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e as List<int>))['message']);
    }
  }

  Future<bool> editSecondName(String name) async {
    const String _path =
        NetworkConstants.baseUrl + NetworkConstants.editLastName;

    try {
      final resp = await http.post(Uri.parse(_path), body: {
        "last_name": name,
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        return true;
      } else {
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e as List<int>))['message']);
    }
  }

  Future<bool> editEmailAddress(String email) async {
    const String _path =
        NetworkConstants.baseUrl + NetworkConstants.editEmailAddress;

    try {
      final resp = await http.post(Uri.parse(_path),
          body: {"email": email, "LanguageCode": _authRepo.currentLanguageCode},
          headers: {"Authorization": "Token $currentToken"});
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        return true;
      } else {
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e as List<int>))['message']);
    }
  }

  Future<bool> editMobile(String mobile) async {
    const String _path = NetworkConstants.baseUrl + NetworkConstants.editMobile;

    try {
      final resp = await http.post(Uri.parse(_path), body: {
        "mobile": mobile,
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
        return true;
      } else {
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e as List<int>))['message']);
    }
  }

  Future<bool> editPassword(Map<String, String> body) async {
    final String _path =
        NetworkConstants.baseUrl + NetworkConstants.editPassword;

    try {
      final resp = await http.post(Uri.parse(_path), body: {
        "old_password": body["old_password"],
        "password1": body["password1"],
        "password2": body["password2"],
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 200) {
        return true;
      } else {
        return Future.error(
            json.decode(utf8.decode(resp.bodyBytes))['message']);
      }
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e as List<int>))['message']);
    }
  }

  Future uploadProfilePicture(File imageFile) async {
    bool hasBeenUploaded;
    // open a bytestream
    final stream =
        // ignore: deprecated_member_use
        http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    final length = await imageFile.length();
    const String _path =
        NetworkConstants.baseUrl + NetworkConstants.uploadProfilePicture;

    // string to uri
    final uri = Uri.parse(_path);

    // create multipart request
    final request = http.MultipartRequest("POST", uri);
    request.headers.addAll({"Authorization": "Token $currentToken"});

    // multipart that takes file
    final multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    final response = await request.send();

    // listen for response
    // ignore: void_checks
    response.stream.transform(utf8.decoder).listen((value) {
      if (json.decode(value)['status'] == 201) {
        hasBeenUploaded = true;
      } else {
        hasBeenUploaded = false;
      }
      return hasBeenUploaded;
    });
    return true;
  }

  Future<bool> uploadCover(File imageFile) async {
    print("Start Uploading Image File");
    // open a bytestream
    final stream =
        // ignore: deprecated_member_use
        http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    final length = await imageFile.length();
    final String _path =
        NetworkConstants.baseUrl + NetworkConstants.uploadCoverPicture;

    // string to uri
    final uri = Uri.parse(_path);

    // create multipart request
    final request = http.MultipartRequest("POST", uri);
    request.headers.addAll({"Authorization": "Token $currentToken"});

    // multipart that takes file
    final multipartFile = http.MultipartFile('CoverImage', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    final response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {});
    return true;
  }

  Future<WalletTotalData> getWalletTotalData() async {
    final String _path =
        NetworkConstants.baseUrl + NetworkConstants.walletTotal;
    try {
      final resp = await http.post(Uri.parse(_path),
          headers: {"Authorization": "Token $currentToken"},
          body: {"LanguageCode": _authRepo.currentLanguageCode});
      final respData =
          json.decode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
      final WalletTotalData walletTotalData =
          WalletTotalData.fromJson(respData);

      return walletTotalData;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<WalletPointsToPrice> walletPointsToPrice(String points) async {
    final String _path =
        NetworkConstants.baseUrl + NetworkConstants.walletPointsToPrice;
    try {
      final resp = await http.post(Uri.parse(_path), headers: {
        "Authorization": "Token $currentToken"
      }, body: {
        "LanguageCode": _authRepo.currentLanguageCode,
        "points": points
      });
      final respData =
          json.decode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
      final WalletPointsToPrice pointsToPrice =
          WalletPointsToPrice.fromJson(respData);

      return pointsToPrice;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future walletTransformPoints(String points) async {
    final String _path = NetworkConstants.baseUrl +
        NetworkConstants.walletTransformPointsToPrice;
    try {
      final resp = await http.post(Uri.parse(_path), headers: {
        "Authorization": "Token $currentToken"
      }, body: {
        "RequestType": "API",
        "LanguageCode": _authRepo.currentLanguageCode,
        "points": points
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));

      return respData;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> walletTransformPromocode(
      String promocode) async {
    final String _path =
        NetworkConstants.baseUrl + NetworkConstants.walletTransformPromocode;
    try {
      final resp = await http.post(Uri.parse(_path), headers: {
        "Authorization": "Token $currentToken"
      }, body: {
        "LanguageCode": _authRepo.currentLanguageCode,
        "PromoCode": promocode
      });
      final respData =
          json.decode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;

      return respData;
    } catch (e) {
      return Future.error(e);
    }
  }

  void logOut() {}
  String get currentToken {
    return _authRepo.currentUserToken;
  }
}
