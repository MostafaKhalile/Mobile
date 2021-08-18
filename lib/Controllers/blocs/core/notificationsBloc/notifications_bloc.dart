import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techtime/Controllers/Repositories/notifications/repository.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepo _notificationsRepo;
  NotificationsBloc(this._notificationsRepo) : super(NotificationsInitial());

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is GetAllUserNotifications) {
      yield NotificationsLoading();
      try {
        final AllNotifications notifications =
            await _notificationsRepo.getUserNotifications();
        yield NotificationsSuccess(notifications);
      } catch (e) {
        yield NotificationsFaild(e.toString());
      }
    }
  }
}
