part of 'editpassword_bloc.dart';

abstract class EditpasswordState extends Equatable {
  const EditpasswordState();

  @override
  List<Object> get props => [];
}

class EditpasswordInitial extends EditpasswordState {}

class EditpasswordLoading extends EditpasswordState {}

class Editpasswordsuccess extends EditpasswordState {}

class EditpasswordFaild extends EditpasswordState {
  final String message;

  EditpasswordFaild(this.message);
}
