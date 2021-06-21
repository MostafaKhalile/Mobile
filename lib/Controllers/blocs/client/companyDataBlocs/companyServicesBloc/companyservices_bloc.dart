import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/companies/companies_repository.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';

part 'companyservices_event.dart';
part 'companyservices_state.dart';

class CompanyservicesBloc
    extends Bloc<CompanyservicesEvent, CompanyservicesState> {
  CompanyservicesBloc(this._companiesRepo) : super(CompanyservicesInitial());
  final APICompaniesRepository _companiesRepo;

  @override
  Stream<CompanyservicesState> mapEventToState(
    CompanyservicesEvent event,
  ) async* {
    if (event is GetCompanyServices) {
      yield CompanyservicesLoading();
      try {
        final companies =
            await _companiesRepo.getCompanyServices(event.branchId);
        yield CompanyservicesSuccess(companies);
      } catch (e) {
        yield CompanyservicesFaild(e.toString());
      }
    }
  }
}
