part of 'editfirstname_bloc.dart';

abstract class EditfirstnameEvent extends Equatable {
  const EditfirstnameEvent();

  @override
  List<Object> get props => [];
}

class EditFirstName extends EditfirstnameEvent {
  final String firstName;

  const EditFirstName(this.firstName);
}
