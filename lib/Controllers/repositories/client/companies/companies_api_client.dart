import 'package:techtime/Models/client/companyProfile/company_service.dart';

import 'companies_repository.dart';

class CompaniesApiClient {
  final APICompaniesRepository companiesRepo = APICompaniesRepository();

  Future<List<CompanyService>> getCompanyServices(int branchId) async {
    try {
      final dataResp = await companiesRepo.getCompanyServices(branchId);
      return dataResp;
    } catch (e) {
      return Future.error("Error");
      // json.decode(utf8.decode(e.bodyBytes as List<int>))['message']
    }
  }
}
