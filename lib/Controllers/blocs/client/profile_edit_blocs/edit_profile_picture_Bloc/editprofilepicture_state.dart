part of 'editprofilepicture_bloc.dart';

abstract class EditprofilepictureState extends Equatable {
  const EditprofilepictureState();

  @override
  List<Object> get props => [];
}

class EditprofilepictureInitial extends EditprofilepictureState {}

class EditprofilepictureUploading extends EditprofilepictureState {}

class EditprofilepictureDone extends EditprofilepictureState {}

class EditprofilepictureFailure extends EditprofilepictureState {}
