import 'package:techtime/Models/client/branche.dart';
import 'package:techtime/Models/client/company.dart';

import 'api_client.dart';

class FavoritesRepo {
  final FavoritesApiClient _apiClient = FavoritesApiClient();

  Future<List<Company>> getUserfavoriteCompanies() async {
    final userFavoriteCompanies = await _apiClient.getUserfavoriteCompanies();

    return userFavoriteCompanies;
  }

  Future<List<BrancheData>> getUserfavoriteBranches() async {
    final userFavoriteBranches = await _apiClient.getUserfavoriteBranches();

    return userFavoriteBranches;
  }
}
