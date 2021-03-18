import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/repositories/client/home/user_home_repo.dart';
import 'package:techtime/models/client/company.dart';

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
