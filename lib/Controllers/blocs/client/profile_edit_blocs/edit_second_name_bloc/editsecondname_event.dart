part of 'editsecondname_bloc.dart';

abstract class EditLastnameEvent extends Equatable {
  const EditLastnameEvent();

  @override
  List<Object> get props => [];
}

class EditLastName extends EditLastnameEvent {
  final String lastName;

  EditLastName(this.lastName);
}
