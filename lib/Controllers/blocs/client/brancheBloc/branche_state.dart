part of 'branche_bloc.dart';

abstract class BrancheState extends Equatable {
  const BrancheState();
  
  @override
  List<Object> get props => [];
}

class BrancheInitial extends BrancheState {}
