part of 'branche_profile_bloc.dart';

abstract class BrancheProfileEvent extends Equatable {
  const BrancheProfileEvent();

  @override
  List<Object> get props => [];
}

class GetBrancheProfile extends BrancheProfileEvent {
  final int id;
  const GetBrancheProfile(this.id);
}
