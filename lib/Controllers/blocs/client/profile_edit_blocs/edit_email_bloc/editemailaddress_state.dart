part of 'editemailaddress_bloc.dart';

abstract class EditemailaddressState extends Equatable {
  const EditemailaddressState();

  @override
  List<Object> get props => [];
}

class EditemailaddressInitial extends EditemailaddressState {}

class EditEmailAddressInitial extends EditemailaddressState {}

class EditEmailAddressLoading extends EditemailaddressState {}

class EditEmailAddresssuccess extends EditemailaddressState {}

class EditEmailAddressFaild extends EditemailaddressState {
  final String message;

  const EditEmailAddressFaild(this.message);
}
