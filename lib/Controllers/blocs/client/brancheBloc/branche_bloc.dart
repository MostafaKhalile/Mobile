import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'branche_event.dart';
part 'branche_state.dart';

class BrancheBloc extends Bloc<BrancheEvent, BrancheState> {
  BrancheBloc() : super(BrancheInitial());

  @override
  Stream<BrancheState> mapEventToState(
    BrancheEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
