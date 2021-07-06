part of 'editfirstname_bloc.dart';

abstract class EditfirstnameState extends Equatable {
  const EditfirstnameState();

  @override
  List<Object> get props => [];
}

class EditFirstNameInitial extends EditfirstnameState {}

class EditFirstNameLoading extends EditfirstnameState {}

class EditFirstNamesuccess extends EditfirstnameState {}

class EditFirstNameFaild extends EditfirstnameState {
  final String message;

  const EditFirstNameFaild(this.message);
}
