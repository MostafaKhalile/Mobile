part of 'editemailaddress_bloc.dart';

abstract class EditemailaddressEvent extends Equatable {
  const EditemailaddressEvent();

  @override
  List<Object> get props => [];
}

class EditEmailAddress extends EditemailaddressEvent {
  final String emailAddress;

  EditEmailAddress(this.emailAddress);
}
