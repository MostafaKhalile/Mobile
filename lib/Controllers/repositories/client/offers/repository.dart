import 'package:techtime/Models/client/offers/company_offer.dart';
import 'package:techtime/Models/client/offers/company_offers.dart';

import 'api_client.dart';

class OffersRepo {
  final OffersApiClient _apiClient = OffersApiClient();

  Future<List<CompanyDataOffer>> getAllCompaniesOffers() async {
    final userFavoriteCompanies = await _apiClient.getAllCompaniesOffers();

    return userFavoriteCompanies;
  }

  Future<CompanyOffers> filterOffersCompany(int id) async {
    final companyOffers = await _apiClient.filterOffersCompany(id);

    return companyOffers;
  }
}
