import 'dart:convert';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/branche.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/Models/client/offers/company_offer.dart';

class OffersApiClient {
  // final AuthRepo _authRepo = AuthRepo();
  final headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json",
    "Authorization": "Token ${AuthRepo().currentUserToken}"
  };

  Future<List<CompanyOffer>> getAllCompaniesOffers() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.allCompaniesOffers;
    final response =
        await http.post(Uri.parse(path), headers: NetworkConstants.headers);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)['CompanyData'] as List;

      return data.map((rawPost) {
        return CompanyOffer.fromJson(rawPost as Map<String, dynamic>);
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
