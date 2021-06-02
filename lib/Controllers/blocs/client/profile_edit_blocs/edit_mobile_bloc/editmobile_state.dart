part of 'editmobile_bloc.dart';

abstract class EditmobileState extends Equatable {
  const EditmobileState();

  @override
  List<Object> get props => [];
}

class EditmobileInitial extends EditmobileState {}

class EditMobileLoading extends EditmobileState {}

class EditMobilesuccess extends EditmobileState {}

class EditMobileFaild extends EditmobileState {
  final String message;

  EditMobileFaild(this.message);
}
