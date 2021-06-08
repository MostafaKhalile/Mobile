part of 'editpassword_bloc.dart';

abstract class EditpasswordEvent extends Equatable {
  const EditpasswordEvent();

  @override
  List<Object> get props => [];
}

class EditPassword extends EditpasswordEvent {
  final Map<String, String> body;

  EditPassword(this.body);
}
