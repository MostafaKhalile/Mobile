import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Helpers/shared_perfs_provider.dart';
import 'package:techtime/Models/client/wallet/wallet_points_to_price.dart';
import 'package:techtime/Models/client/wallet/wallet_total_data.dart';
import 'package:techtime/Models/user_notification.dart';

class AccountApiClient {
  final PreferenceUtils prefs;
  final AuthRepo _authRepo = AuthRepo();

  AccountApiClient({
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
      var resp = await http.post(Uri.parse(_path), body: {
        "first_name": name,
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 201) {
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
      var resp = await http.post(Uri.parse(_path), body: {
        "last_name": name,
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
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

  Future<bool> editMobile(String mobile) async {
    final String _path = KAPIURL + NetworkConstants.editMobile;

    try {
      var resp = await http.post(Uri.parse(_path), body: {
        "mobile": mobile,
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
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

  Future<bool> editPassword(Map<String, String> body) async {
    final String _path = KAPIURL + NetworkConstants.editPassword;

    try {
      var resp = await http.post(Uri.parse(_path), body: {
        "old_password": body["old_password"],
        "password1": body["password1"],
        "password2": body["password2"],
        "LanguageCode": _authRepo.currentLanguageCode
      }, headers: {
        "Authorization": "Token $currentToken"
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      if (respData["status"] == 200) {
        print("Password has been edited $respData");
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

  Future uploadProfilePicture(File imageFile) async {
    bool hasBeenUploaded;
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    final String _path = KAPIURL + NetworkConstants.uploadProfilePicture;

    // string to uri
    var uri = Uri.parse(_path);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll({"Authorization": "Token $currentToken"});

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();

    // listen for response
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

  uploadCover(File imageFile) async {
    print("Start Uploading Image File");
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    final String _path = KAPIURL + NetworkConstants.uploadCoverPicture;

    // string to uri
    var uri = Uri.parse(_path);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll({"Authorization": "Token $currentToken"});

    // multipart that takes file
    var multipartFile = new http.MultipartFile('CoverImage', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.toString());

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    return true;
  }

  Future<WalletTotalData> getWalletTotalData() async {
    final String _path = KAPIURL + NetworkConstants.walletTotal;
    try {
      var resp = await http.post(Uri.parse(_path),
          headers: {"Authorization": "Token $currentToken"},
          body: {"LanguageCode": _authRepo.currentLanguageCode});
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      final WalletTotalData walletTotalData =
          WalletTotalData.fromJson(respData);
      print(walletTotalData.toString());
      return walletTotalData;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<WalletPointsToPrice> walletPointsToPrice(String points) async {
    final String _path = KAPIURL + NetworkConstants.walletPointsToPrice;
    try {
      var resp = await http.post(Uri.parse(_path), headers: {
        "Authorization": "Token $currentToken"
      }, body: {
        "LanguageCode": _authRepo.currentLanguageCode,
        "points": points
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      final WalletPointsToPrice pointsToPrice =
          WalletPointsToPrice.fromJson(respData);
      print(pointsToPrice.toString());
      return pointsToPrice;
    } catch (e) {
      return Future.error(e);
    }
  }

  walletTransformPoints(String points) async {
    final String _path =
        KAPIURL + NetworkConstants.walletTransformPointsToPrice;
    try {
      var resp = await http.post(Uri.parse(_path), headers: {
        "Authorization": "Token $currentToken"
      }, body: {
        "RequestType": "API",
        "LanguageCode": _authRepo.currentLanguageCode,
        "points": points
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      print(respData);
      return respData;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> walletTransformPromocode(
      String promocode) async {
    final String _path = KAPIURL + NetworkConstants.walletTransformPromocode;
    try {
      var resp = await http.post(Uri.parse(_path), headers: {
        "Authorization": "Token $currentToken"
      }, body: {
        "LanguageCode": _authRepo.currentLanguageCode,
        "PromoCode": promocode
      });
      final respData = json.decode(utf8.decode(resp.bodyBytes));
      print(respData);
      return respData;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<UserNotification>> getUserNotifications() async {
    final String path = KAPIURL + NetworkConstants.allUserNotification;
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${_authRepo.currentUserToken}"
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      print("Company services here $decoded");
      final data = json.decode(decoded)['AllNotification'] as List;
      return data.map((rawPost) {
        return UserNotification.fromJson(rawPost);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  void logOut() {}
  String get currentToken {
    return _authRepo.currentUserToken;
  }
}
