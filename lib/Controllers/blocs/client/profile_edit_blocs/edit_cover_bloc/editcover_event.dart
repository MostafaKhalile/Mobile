part of 'editcover_bloc.dart';

abstract class EditcoverEvent extends Equatable {
  const EditcoverEvent();

  @override
  List<Object> get props => [];
}

class ChangeCover extends EditcoverEvent {
  final File image;
  ChangeCover(this.image);
}
