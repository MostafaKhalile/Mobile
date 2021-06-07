part of 'editcover_bloc.dart';

abstract class EditcoverState extends Equatable {
  const EditcoverState();

  @override
  List<Object> get props => [];
}

class EditcoverInitial extends EditcoverState {}

class EditCoverUploading extends EditcoverState {}

class EditCoverDone extends EditcoverState {}

class EditCoverFailure extends EditcoverState {}
