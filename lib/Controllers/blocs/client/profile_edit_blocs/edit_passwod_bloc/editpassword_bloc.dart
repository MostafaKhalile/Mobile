import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editpassword_event.dart';
part 'editpassword_state.dart';

class EditpasswordBloc extends Bloc<EditpasswordEvent, EditpasswordState> {
  EditpasswordBloc(this._userRepo) : super(EditpasswordInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditpasswordState> mapEventToState(
    EditpasswordEvent event,
  ) async* {
    if (event is EditPassword) {
      try {
        yield EditpasswordLoading();
        final hasEdited = await _userRepo.editPassword(event.body);
        if (hasEdited == true) {
          yield Editpasswordsuccess();
        }
      } catch (e) {
        yield EditpasswordFaild(e.toString());
      }
    }
  }
}
