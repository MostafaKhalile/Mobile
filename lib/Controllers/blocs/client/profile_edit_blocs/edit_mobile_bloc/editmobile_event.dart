part of 'editmobile_bloc.dart';

abstract class EditmobileEvent extends Equatable {
  const EditmobileEvent();

  @override
  List<Object> get props => [];
}

class EditMobile extends EditmobileEvent {
  final String mobile;

  EditMobile(this.mobile);
}
