import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/branches/branches_repository.dart';
import 'package:techtime/Models/client/brancheData/brancheProfile/branche_profile.dart';

part 'branche_profile_event.dart';
part 'branche_profile_state.dart';

class BrancheProfileBloc
    extends Bloc<BrancheProfileEvent, BrancheProfileState> {
  BrancheProfileBloc(this._branchesRepo) : super(BrancheProfileInitial());
  final BranchesRepository _branchesRepo;

  @override
  Stream<BrancheProfileState> mapEventToState(
    BrancheProfileEvent event,
  ) async* {
    if (event is GetBrancheProfile) {
      try {
        yield BrancheProfileLoading();
        BrancheProfile brancheProfile =
            await _branchesRepo.getBrancheProfileData(event.id);
        yield BrancheProfileSuccess(brancheProfile);
      } catch (e) {
        print("Error Message here $e");
        yield BrancheProfileFailed(e.toString());
      }
    }
  }
}
