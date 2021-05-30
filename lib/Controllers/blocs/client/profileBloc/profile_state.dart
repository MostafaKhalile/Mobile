part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileDataLoading extends ProfileState {}

class ProfileDataLoaded extends ProfileState {
  final USerProfile profile;

  ProfileDataLoaded(this.profile);
}

class ProfileDataError extends ProfileState {
  final String message;

  ProfileDataError({this.message});
}
