import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editsecondname_event.dart';
part 'editsecondname_state.dart';

class EditLastnameBloc extends Bloc<EditLastnameEvent, EditLastnameState> {
  EditLastnameBloc(this._userRepo) : super(EditLastnameInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditLastnameState> mapEventToState(
    EditLastnameEvent event,
  ) async* {
    if (event is EditLastName) {
      try {
        yield EditLastNameLoading();
        final hasEdited = await _userRepo.editFirstName(event.lastName);
        if (hasEdited == true) {
          yield EditLastNamesuccess();
        }
      } catch (e) {
        print(e.toString());
        yield EditLastNameFaild(e.toString());
      }
    }
  }
}
