import 'package:techtime/Models/client/branche.dart';
import 'package:techtime/Models/client/offers/company_offer.dart';

import 'api_client.dart';

class OffersRepo {
  final OffersApiClient _apiClient = OffersApiClient();

  Future<List<CompanyOffer>> getAllCompaniesOffers() async {
    final userFavoriteCompanies = await _apiClient.getAllCompaniesOffers();

    return userFavoriteCompanies;
  }

  Future<List<BrancheData>> getUserfavoriteBranches() async {
    final userFavoriteBranches = await _apiClient.getUserfavoriteBranches();

    return userFavoriteBranches;
  }
}
