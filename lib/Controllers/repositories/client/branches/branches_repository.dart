import 'package:techtime/Models/client/brancheData/brancheProfile/branche_profile.dart';

import 'branches_api_client.dart';

class BranchesRepository {
  BranchesApiClient _branchesApiClient = BranchesApiClient();
  Future<BrancheProfile> getBrancheProfileData(int branchId) async {
    try {
      final dataResp = await _branchesApiClient.getBrancheProfile(branchId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> brancheAddRemoveFavorite(int branchId) async {
    try {
      final dataResp =
          await _branchesApiClient.brancheAddRemoveFavorite(branchId);
      return dataResp;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
