part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final AllNotifications notifications;

  NotificationsSuccess(this.notifications);
}

class NotificationsFaild extends NotificationsState {
  final String message;

  NotificationsFaild(this.message);
}
