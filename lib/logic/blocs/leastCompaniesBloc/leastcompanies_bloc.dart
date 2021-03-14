import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/data/models/company.dart';
import 'package:techtime/data/repositories/user_home_repo.dart';

part 'leastcompanies_event.dart';
part 'leastcompanies_state.dart';

class LeastcompaniesBloc
    extends Bloc<LeastcompaniesEvent, LeastcompaniesState> {
  final APIClientHomeRepository _clientHomeRepo;

  LeastcompaniesBloc(this._clientHomeRepo) : super(LeastcompaniesInitial());

  @override
  Stream<LeastcompaniesState> mapEventToState(
    LeastcompaniesEvent event,
  ) async* {
    if (event is GetLeastCompanies) {
      try {
        yield Leastcompaniesloading();
        final leastCompanies = await _clientHomeRepo.fetchLeastCo;
        yield LeastCompaniesLoaded(leastCompanies);
      } catch (e) {
        yield LeastCompaniesError(e.toString());
      }
    }
  }
}
