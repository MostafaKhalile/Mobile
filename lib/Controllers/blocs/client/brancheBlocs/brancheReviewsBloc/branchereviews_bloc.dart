import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheReviews/branche_reviews.dart';

part 'branchereviews_event.dart';
part 'branchereviews_state.dart';

class BranchereviewsBloc
    extends Bloc<BranchereviewsEvent, BranchereviewsState> {
  BranchereviewsBloc(this._branchesRepo) : super(BranchereviewsInitial());
  final BranchesRepository _branchesRepo;

  @override
  Stream<BranchereviewsState> mapEventToState(
    BranchereviewsEvent event,
  ) async* {
    if (event is GetBrancheReviews) {
      yield BrancheReviewsLoading();
      try {
        final companies = await _branchesRepo.getBrancheReviews(event.branchId);
        yield BrancheReviewsSuccess(companies);
      } catch (e) {
        yield BrancheReviewsFaild(e.toString());
      }
    }
  }
}
