import 'dart:convert';

import 'package:techtime/Models/client/companyData/company_service.dart';

import 'companies_repository.dart';

class CompaniesApiClient {
  final APICompaniesRepository companiesRepo = APICompaniesRepository();

  Future<List<CompanyService>> getCompanyServices(int branchId) async {
    try {
      final dataResp = await companiesRepo.getCompanyServices(branchId);
      print(dataResp.toString());
      return dataResp;
    } catch (e) {
      return Future.error(json.decode(utf8.decode(e.bodyBytes))['message']);
    }
  }
}
