import 'dart:convert';

import 'package:techtime/Helpers/network_constants.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/Models/client/offers/company_offer.dart';
import 'package:techtime/Models/client/offers/company_offers.dart';

class OffersApiClient {
  // final AuthRepo _authRepo = AuthRepo();
  final headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json",
  };

  Future<List<CompanyDataOffer>> getAllCompaniesOffers() async {
    const String path =
        NetworkConstants.baseUrl + NetworkConstants.allCompaniesOffers;
    final response =
        await http.post(Uri.parse(path), headers: NetworkConstants.headers);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)["CompanyData"] as List;

      return data.map((rawPost) {
        return CompanyDataOffer.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<CompanyOffers> filterOffersCompany(int? id) async {
    final String path =
        "${NetworkConstants.baseUrl}${NetworkConstants.filterOffersCompany}$id";
    final response = await http.post(Uri.parse(path), headers: headers);
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded);

      return CompanyOffers.fromJson(data as Map<String, dynamic>);
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }
}
