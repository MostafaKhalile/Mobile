import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editfirstname_event.dart';
part 'editfirstname_state.dart';

class EditfirstnameBloc extends Bloc<EditfirstnameEvent, EditfirstnameState> {
  EditfirstnameBloc(this._userRepo) : super(EditFirstNameInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditfirstnameState> mapEventToState(
    EditfirstnameEvent event,
  ) async* {
    if (event is EditFirstName) {
      try {
        yield EditFirstNameLoading();
        final hasEdited = await _userRepo.editFirstName(event.firstName);
        if (hasEdited == true) {
          yield EditFirstNamesuccess();
        }
      } catch (e) {
        yield EditFirstNameFaild(e.toString());
      }
    }
  }
}
