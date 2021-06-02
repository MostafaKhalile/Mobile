import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editmobile_event.dart';
part 'editmobile_state.dart';

class EditmobileBloc extends Bloc<EditmobileEvent, EditmobileState> {
  EditmobileBloc(this._userRepo) : super(EditmobileInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditmobileState> mapEventToState(
    EditmobileEvent event,
  ) async* {
    if (event is EditMobile) {
      try {
        yield EditMobileLoading();
        final hasEdited = await _userRepo.editMobile(event.mobile);
        if (hasEdited == true) {
          yield EditMobilesuccess();
        }
      } catch (e) {
        print(e.toString());
        yield EditMobileFaild(e.toString());
      }
    }
  }
}
