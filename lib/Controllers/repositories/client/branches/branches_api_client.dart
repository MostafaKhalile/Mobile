import 'dart:convert';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';

import 'package:http/http.dart' as http;
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheOffers/branche_offers.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheProfile/branche_profile.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheReviews/branche_reviews.dart';
import 'package:techtime/Models/client/companyData/brancheData/branche_working_day.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';

class BranchesApiClient {
  AuthRepo authRepo = AuthRepo();

  Future<BrancheProfile> getBrancheProfile(int id) async {
    final String path =
        NetworkConstants.baseUrl + NetworkConstants.viewBranche + id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded) as Map<String, dynamic>;

      return BrancheProfile.fromJson(data);
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<bool> brancheAddRemoveFavorite(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.brancheAddRemoveFavorite +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
      "Authorization": "Token ${authRepo.currentUserToken}"
    });
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded);

      return data['Favorite'] as bool;
    } else {
      return false;
    }
  }

  Future<List<CompanyService>> getBrancheServices(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.viewBranchServices +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)['AllBranchServices'] as List;
      return data.map((rawPost) {
        return CompanyService.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error('${json.decode(response.body)}');
    }
  }

  Future<List<CompanyEmployee>> getBrancheEmployees(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.viewBranchemployees +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)['AllBranchEmployees'] as List;
      return data.map((rawPost) {
        return CompanyEmployee.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error(json.decode(response.body).toString());
    }
  }

  Future<BrancheReviews> getBrancheReviews(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.viewBranchReviews +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded);
      return BrancheReviews.fromJson(data as Map<String, dynamic>);
    } else {
      throw Future.error(json.decode(response.body).toString());
    }
  }

  Future<List<BrancheOffer>> getBrancheOffers(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.viewBranchOffers +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)['SendBranchOffers'] as List;
      return data.map((rawPost) {
        return BrancheOffer.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error(json.decode(response.body).toString());
    }
  }

  Future<List<BrancheWorkingDay>> getBrancheWorkingDays(int id) async {
    final String path = NetworkConstants.baseUrl +
        NetworkConstants.viewBranchWorkingDays +
        id.toString();
    final response = await http.post(Uri.parse(path), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = json.decode(decoded)['AllBranchWorkDays'] as List;
      return data.map((rawPost) {
        return BrancheWorkingDay.fromJson(rawPost as Map<String, dynamic>);
      }).toList();
    } else {
      throw Future.error(json.decode(response.body).toString());
    }
  }
}
