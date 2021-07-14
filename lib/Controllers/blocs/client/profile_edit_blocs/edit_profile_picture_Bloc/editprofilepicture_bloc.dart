import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editprofilepicture_event.dart';
part 'editprofilepicture_state.dart';

class EditprofilepictureBloc
    extends Bloc<EditprofilepictureEvent, EditprofilepictureState> {
  EditprofilepictureBloc(this._userRepo) : super(EditprofilepictureInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditprofilepictureState> mapEventToState(
    EditprofilepictureEvent event,
  ) async* {
    if (event is ChangeProfilePicture) {
      try {
        yield EditprofilepictureUploading();
        final hasEdited = await _userRepo.uploadProfilePicture(event.image);
        if (hasEdited == true) {
          yield EditprofilepictureDone();
        } else {
          yield EditprofilepictureFailure();
        }
      // ignore: empty_catches
      } catch (e) {}
    }
  }
}
