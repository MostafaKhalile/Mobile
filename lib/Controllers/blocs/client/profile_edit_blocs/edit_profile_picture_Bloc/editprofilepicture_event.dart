part of 'editprofilepicture_bloc.dart';

abstract class EditprofilepictureEvent extends Equatable {
  const EditprofilepictureEvent();

  @override
  List<Object> get props => [];
}

class ChangeProfilePicture extends EditprofilepictureEvent {
  final File image;
  const ChangeProfilePicture(this.image);
}
