import 'package:techtime/Models/client/companyData/brancheData/brancheOffers/branche_offers.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheProfile/branche_profile.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheReviews/branche_reviews.dart';
import 'package:techtime/Models/client/companyData/brancheData/branche_working_day.dart';
import 'package:techtime/Models/client/companyData/brancheData/company_employee.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';

import 'branches_api_client.dart';

class BranchesRepository {
  final BranchesApiClient _branchesApiClient = BranchesApiClient();
  Future<BrancheProfile> getBrancheProfileData(int brancheId) async {
    try {
      final dataResp = await _branchesApiClient.getBrancheProfile(brancheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> brancheAddRemoveFavorite(int brancheId) async {
    try {
      final dataResp =
          await _branchesApiClient.brancheAddRemoveFavorite(brancheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<CompanyService>> getBrancheServices(int brancheId) async {
    try {
      final dataResp = await _branchesApiClient.getBrancheServices(brancheId);
      print(dataResp.toString());
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<CompanyEmployee>> getBrancheEmployees(int brancheId) async {
    try {
      final dataResp = await _branchesApiClient.getBrancheEmployees(brancheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<BrancheReviews> getBrancheReviews(int branheId) async {
    try {
      final dataResp = await _branchesApiClient.getBrancheReviews(branheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<BrancheOffer>> getBrancheOffers(int brancheId) async {
    try {
      final dataResp = await _branchesApiClient.getBrancheOffers(brancheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<BrancheWorkingDay>> getBrancheWorkingDays(int brancheId) async {
    try {
      final dataResp =
          await _branchesApiClient.getBrancheWorkingDays(brancheId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
