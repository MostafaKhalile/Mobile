part of 'authantication_bloc.dart';

abstract class AuthanticationState extends Equatable {
  final Key key;
  const AuthanticationState(this.key);

  @override
  List<Object> get props => [key];
}

class AuthanticationInitial extends AuthanticationState {
  AuthanticationInitial({Key key}) : super(key);
}

/*

*/

class LoginInProgress extends AuthanticationState {
  LoginInProgress({Key key}) : super(key);
}

class LoginSuccesseded extends AuthanticationState {
  final User user;

  const LoginSuccesseded(this.user, {Key key}) : super(key);

  @override
  List<Object> get props => [user];
}

class LoginFailed extends AuthanticationState {
  final String message;
  final Key key;
  const LoginFailed({@required this.message, this.key})
      : assert(message != null),
        super(key);
  @override
  List<Object> get props => [
        message,
      ];
}

/*

*/

class CheckCodeInProgress extends AuthanticationState {
  CheckCodeInProgress({Key key}) : super(key);
}

class CheckCodeSuccesseded extends AuthanticationState {
  final User user;

  const CheckCodeSuccesseded({@required this.user})
      : assert(user != null),
        super(null);

  @override
  List<Object> get props => [user];
}

class CheckCodeFailed extends AuthanticationState {
  final String message;
  const CheckCodeFailed({@required this.message})
      : assert(message != null),
        super(null);
  @override
  List<Object> get props => [message];
}

/*

*/
class RegisterInProgress extends AuthanticationState {
  RegisterInProgress({Key key}) : super(key);
}

class RegisterSuccesseded extends AuthanticationState {
  RegisterSuccesseded({Key key}) : super(key);
}

class RegisterFailed extends AuthanticationState {
  final String message;
  const RegisterFailed({@required this.message, Key key})
      : assert(message != null),
        super(key);
  @override
  List<Object> get props => [message];
}

class LogOutInProgress extends AuthanticationState {
  LogOutInProgress({Key key}) : super(key);
}

class LogOutSuccesseded extends AuthanticationState {
  LogOutSuccesseded({Key key}) : super(key);
}

class LogOutFailed extends AuthanticationState {
  final String message;
  const LogOutFailed({@required this.message})
      : assert(message != null),
        super(null);
  @override
  List<Object> get props => [message];
}
