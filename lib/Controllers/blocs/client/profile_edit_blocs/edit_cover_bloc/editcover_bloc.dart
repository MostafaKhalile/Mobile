import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editcover_event.dart';
part 'editcover_state.dart';

class EditcoverBloc extends Bloc<EditcoverEvent, EditcoverState> {
  EditcoverBloc(this._userRepo) : super(EditcoverInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditcoverState> mapEventToState(
    EditcoverEvent event,
  ) async* {
    if (event is ChangeCover) {
      try {
        yield EditCoverUploading();
        final hasEdited = await _userRepo.uploadCover(event.image);
        if (hasEdited == true) {
          yield EditCoverDone();
        } else {
          yield EditCoverFailure();
        }
      // ignore: empty_catches
      } catch (e) {}
    }
  }
}
