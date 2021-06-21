import 'dart:convert';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyData/company_service.dart';
import 'package:techtime/Models/client/company.dart';
import 'package:techtime/Models/client/companyProfile/company_profile.dart';

class APICompaniesRepository {
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json"
  };
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
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<List<CompanyService>> getCompanyServices(int id) async {
    final String path =
        KAPIURL + NetworkConstants.ViewBranchServices + id.toString();
    final response = await http.post(Uri.parse(path), headers: headers);

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      print("Company services here $decoded");
      final data = json.decode(decoded)['AllBranchServices'] as List;
      return data.map((rawPost) {
        return CompanyService.fromJson(rawPost);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
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
