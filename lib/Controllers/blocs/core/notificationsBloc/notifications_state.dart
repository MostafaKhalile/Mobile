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

  const NotificationsSuccess(this.notifications);
}

class NotificationsFaild extends NotificationsState {
  final String message;

  const NotificationsFaild(this.message);
}
