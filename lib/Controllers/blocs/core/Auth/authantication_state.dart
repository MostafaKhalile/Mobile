part of 'authantication_bloc.dart';

abstract class AuthanticationState extends Equatable {
  const AuthanticationState();

  @override
  List<Object> get props => [];
}

class AuthanticationInitial extends AuthanticationState {
  const AuthanticationInitial() : super();
}

/*

*/

class LoginInProgress extends AuthanticationState {
  const LoginInProgress() : super();
}

class LoginSuccesseded extends AuthanticationState {
  final User user;

  const LoginSuccesseded(
    this.user,
  ) : super();

  @override
  List<Object> get props => [user];
}

class LoginFailed extends AuthanticationState {
  final String message;
  @override
  const LoginFailed({required this.message}) : super();
  @override
  List<Object> get props => [
        message,
      ];
}

/*

*/

class CheckCodeInProgress extends AuthanticationState {
  const CheckCodeInProgress() : super();
}

class CheckCodeSuccesseded extends AuthanticationState {
  final User user;

  const CheckCodeSuccesseded({required this.user}) : super();

  @override
  List<Object> get props => [user];
}

class CheckCodeFailed extends AuthanticationState {
  final String message;
  const CheckCodeFailed({required this.message}) : super();
  @override
  List<Object> get props => [message];
}

/*

*/
class RegisterInProgress extends AuthanticationState {
  const RegisterInProgress() : super();
}

class RegisterSuccesseded extends AuthanticationState {
  const RegisterSuccesseded() : super();
}

class RegisterFailed extends AuthanticationState {
  final String message;
  const RegisterFailed({
    required this.message,
  }) : super();
  @override
  List<Object> get props => [message];
}

class LogOutInProgress extends AuthanticationState {
  const LogOutInProgress() : super();
}

class LogOutSuccesseded extends AuthanticationState {
  const LogOutSuccesseded() : super();
}

class LogOutFailed extends AuthanticationState {
  final String message;
  const LogOutFailed({required this.message}) : super();
  @override
  List<Object> get props => [message];
}
