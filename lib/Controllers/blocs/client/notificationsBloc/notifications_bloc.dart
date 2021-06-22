import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Models/user_notification.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final USerRepo _userRepo;
  NotificationsBloc(this._userRepo) : super(NotificationsInitial());

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is GetAllUserNotifications) {
      yield NotificationsLoading();
      try {
        List<UserNotification> notifications =
            await _userRepo.getUserNotifications();
        yield NotificationsSuccess(notifications);
      } catch (e) {
        print(e.toString());
        yield NotificationsFaild(e.toString());
      }
    }
  }
}
