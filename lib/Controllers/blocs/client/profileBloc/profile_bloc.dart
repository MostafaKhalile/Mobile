import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Models/client_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._userRepo) : super(ProfileInitial());

  final USerRepo _userRepo;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfileData) {
      yield ProfileDataLoading();
      try {
        final UserProfile result = await _userRepo.getProfileData();
        yield ProfileDataLoaded(result);
      } catch (e) {
        yield ProfileDataError(message: e.toString());
      }
    }
  }
}
