part of 'authantication_bloc.dart';

abstract class AuthanticationEvent extends Equatable {
  final Key key;
  const AuthanticationEvent(this.key);

  @override
  List<Object> get props => [key];
}

/*

*/

class StartLogin extends AuthanticationEvent {
  final String email;
  final String password;
  final String fcmToken;

  const StartLogin(
    this.email,
    this.password,
    this.fcmToken, {
    Key key,
  }) : super(key);

  @override
  List<Object> get props => [email, password];
}

/*

*/
class StartLogOut extends AuthanticationEvent {
  StartLogOut({Key key}) : super(key);
}

// class RegisterNewUser extends AuthanticationEvent {
//   final RegisterUser updateUser;

//   const RegisterNewUser({
//     Key key,
//     @required this.updateUser,
//   })  : assert(updateUser != null),
//         super(key);

//   @override
//   List<Object> get props => [updateUser];
// }
