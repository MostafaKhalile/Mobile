part of 'branche_profile_bloc.dart';

abstract class BrancheProfileState extends Equatable {
  const BrancheProfileState();

  @override
  List<Object> get props => [];
}

class BrancheProfileInitial extends BrancheProfileState {}

class BrancheProfileLoading extends BrancheProfileState {}

class BrancheProfileSuccess extends BrancheProfileState {
  final BrancheProfile brancheProfile;

  const BrancheProfileSuccess(this.brancheProfile);
}

class BrancheProfileFailed extends BrancheProfileState {
  final String message;

  const BrancheProfileFailed(this.message);
}
