import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/repositories/client/companies/companies_repository.dart';
import 'package:techtime/models/client/company.dart';
import 'package:techtime/models/client/companyProfile/company_branches.dart';
import 'package:techtime/models/client/companyProfile/company_profile.dart';

part 'company_profile_event.dart';
part 'company_profile_state.dart';

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final APICompaniesRepository _companiesRepo;
  CompanyProfileBloc(this._companiesRepo) : super(CompanyProfileInitial());

  @override
  Stream<CompanyProfileState> mapEventToState(
    CompanyProfileEvent event,
  ) async* {
    if (event is GetCompanyProfile) {
      try {
        yield CompanyProfileLoading();
        CompanyProfile coProfile = await _companiesRepo.companyView(event.id);
        yield CompanyProfileFinished(coProfile);
      } catch (e) {
        print("Error Message here $e");
        yield CompanyProfileError(e.toString());
      }
    }
  }
}
