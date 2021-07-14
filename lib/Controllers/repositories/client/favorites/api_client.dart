import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/branche.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:http/http.dart' as http;

class FavoritesApiClient {
  // final AuthRepo _authRepo = AuthRepo();
  final headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json",
    "Authorization": "Token ${AuthRepo().currentUserToken}"
  };

  Future<List<Company>> getUserfavoriteCompanies() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.userFavoriteCompanies;
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as List;

      return data.map((rawPost) {
        return Company.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<List<BrancheData>> getUserfavoriteBranches() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.userFavoriteBranches;
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)['AllBrancheFavoriteData'] as List;

      return data.map((rawPost) {
        return BrancheData.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }
}
