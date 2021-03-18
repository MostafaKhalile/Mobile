import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/repositories/client/companies/companies_repository.dart';
import 'package:techtime/models/client/company.dart';

part 'companieslist_event.dart';
part 'companieslist_state.dart';

class CompanieslistBloc extends Bloc<CompanieslistEvent, CompanieslistState> {
  CompanieslistBloc(this._companies_repo) : super(CompanieslistInitial());
  final APICompaniesRepository _companies_repo;
  @override
  Stream<CompanieslistState> mapEventToState(
    CompanieslistEvent event,
  ) async* {
    if (event is GetCompaniesList) {
      yield CompanieslistLoading();
      final companies = await _companies_repo.fetchCompaniesList(event.id);
      yield CompanieslistFinished(companies);
      try {} catch (e) {
        yield CompanieslistError(e.toString());
      }
    }
  }
}
