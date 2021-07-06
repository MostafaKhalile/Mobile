part of 'editsecondname_bloc.dart';

abstract class EditLastnameState extends Equatable {
  const EditLastnameState();

  @override
  List<Object> get props => [];
}

class EditLastnameInitial extends EditLastnameState {}

class EditLastNameLoading extends EditLastnameState {}

class EditLastNamesuccess extends EditLastnameState {}

class EditLastNameFaild extends EditLastnameState {
  final String message;

  const EditLastNameFaild(this.message);
}
