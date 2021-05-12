import 'dart:convert';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/models/client/company.dart';
import 'package:techtime/models/client/companyProfile/company_profile.dart';

abstract class CompaniesRepository {
  /// Throws [NetworkException].
  Future<List<Company>> fetchCategoryCompanies(int id);
  Future<CompanyProfile> companyView(int id);
}

class APICompaniesRepository implements CompaniesRepository {
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json"
  };
  @override
  Future<List<Company>> fetchCategoryCompanies(int id) async {
    final response = await http.post(Uri.parse("$KAPIURL$KCompaniesList$id"),
        headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);

      final data = json.decode(decoded) as List;
      return data.map((rawPost) {
        return Company.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('${json.decode(response.body)}');
    }
  }

  Future<CompanyProfile> companyView(int id) async {
    final response = await http.post(Uri.parse("$KAPIURL$KCompanyView$id"),
        headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map;
      final CompanyProfile companyProfile = CompanyProfile.fromJson(data);

      print("#Company PRofile response is $companyProfile");

      return CompanyProfile.fromJson(data);
    } else {
      throw Exception('${json.decode(response.body)}');
    }
  }
}
