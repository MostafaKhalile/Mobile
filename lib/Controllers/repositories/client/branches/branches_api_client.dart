import 'dart:convert';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:http/http.dart' as http;
import 'package:techtime/Helpers/network_constents.dart';
import 'package:techtime/Models/client/brancheData/brancheProfile/branche_profile.dart';
import 'package:techtime/Models/client/companyData/company_service.dart';

class BranchesApiClient {
  AuthRepo authRepo = AuthRepo();

  Future<BrancheProfile> getBrancheProfile(int id) async {
    final String path = KAPIURL + NetworkConstants.ViewBranche + id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${authRepo.currentUserToken}"
    });
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      print("Branche Profile here $decoded");
      final data = json.decode(decoded);

      return BrancheProfile.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<bool> brancheAddRemoveFavorite(int id) async {
    final String path =
        KAPIURL + NetworkConstants.BrancheAddRemoveFavorite + id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${authRepo.currentUserToken}"
    });
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      print("Branche Profile here $decoded");
      final data = json.decode(decoded);

      return data['Favorite'];
    } else {
      return false;
    }
  }

  Future<List<CompanyService>> getBrancheServices(int id) async {
    final String path =
        KAPIURL + NetworkConstants.ViewBranchServices + id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${authRepo.currentUserToken}"
    });

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
}
