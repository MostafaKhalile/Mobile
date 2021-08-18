import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';

part 'editemailaddress_event.dart';
part 'editemailaddress_state.dart';

class EditemailaddressBloc
    extends Bloc<EditemailaddressEvent, EditemailaddressState> {
  EditemailaddressBloc(this._userRepo) : super(EditemailaddressInitial());
  final USerRepo _userRepo;

  @override
  Stream<EditemailaddressState> mapEventToState(
    EditemailaddressEvent event,
  ) async* {
    if (event is EditEmailAddress) {
      try {
        yield EditEmailAddressLoading();
        final hasEdited = await _userRepo.editEmailAddress(event.emailAddress);
        if (hasEdited == true) {
          yield EditEmailAddresssuccess();
        }
      } catch (e) {
        yield EditEmailAddressFaild(e.toString());
      }
    }
  }
}
