import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/data/models/company.dart';
import 'package:techtime/data/repositories/user_home_repo.dart';
part 'recommendedcompanies_event.dart';
part 'recommendedcompanies_state.dart';

class RecommendedcompaniesBloc
    extends Bloc<RecommendedcompaniesEvent, RecommendedcompaniesState> {
  final APIClientHomeRepository _apiClientRepository;
  RecommendedcompaniesBloc(this._apiClientRepository)
      : super(RecommendedcompaniesInitial());

  @override
  Stream<RecommendedcompaniesState> mapEventToState(
    RecommendedcompaniesEvent event,
  ) async* {
    if (event is GetRecommendedCompnies) {
      try {
        yield RecommendedcompaniesLoading();
        final recommendedCo = await _apiClientRepository.fetchRecommendedCo;
        yield RecommendedcompaniesLoaded(recommendedCo);
      } catch (e) {
        yield RecommendedcompaniesError(e.toString());
      }
    }
  }
}
