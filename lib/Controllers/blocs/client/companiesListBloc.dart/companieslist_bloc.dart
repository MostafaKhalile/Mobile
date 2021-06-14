import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/companies/companies_repository.dart';
import 'package:techtime/models/client/company.dart';

part 'companieslist_event.dart';
part 'companieslist_state.dart';

class CompanieslistBloc extends Bloc<CompanieslistEvent, CompanieslistState> {
  CompanieslistBloc(this._companiesRepo) : super(CompanieslistInitial());
  final APICompaniesRepository _companiesRepo;
  @override
  Stream<CompanieslistState> mapEventToState(
    CompanieslistEvent event,
  ) async* {
    if (event is GetCompaniesList) {
      yield CompanieslistLoading();
      final companies = await _companiesRepo.fetchCategoryCompanies(event.id);
      yield CompanieslistFinished(companies);
      try {} catch (e) {
        yield CompanieslistError(e.toString());
      }
    }
  }
}
