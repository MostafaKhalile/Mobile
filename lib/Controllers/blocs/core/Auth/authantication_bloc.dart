import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Models/user.dart';

part 'authantication_event.dart';
part 'authantication_state.dart';

class AuthanticationBloc
    extends Bloc<AuthanticationEvent, AuthanticationState> {
  final AuthRepo authRepo;
  AuthanticationBloc({@required this.authRepo})
      : assert(authRepo != null),
        super(AuthanticationInitial());

  @override
  Stream<AuthanticationState> mapEventToState(
    AuthanticationEvent event,
  ) async* {
    if (event is StartLogin) {
      yield LoginInProgress();
      try {
        // ignore: unused_local_variable
        final result = await authRepo.loginUser(event.email, event.password,event.fcmToken);
        if (result.statusCode == 201) {
          yield LoginSuccesseded(result);
        } else {
          yield LoginFailed(message: result.message);
        }
      } catch (e) {
        yield LoginFailed(message: e.toString(), key: UniqueKey());
      }
    }
    // if (event is StartCheckCode) {
    //   yield CheckCodeInProgress();
    //   try {
    //     final result = await authRepo.checkOTP(
    //       sendCheckCode: _sendCheckCode.copyWith(
    //         phone: _sendCheckCode.phone,
    //         mobileToken: "vhgvhgcv",
    //         code: event.sendCheckCode.code.toString(),
    //       ),
    //     );
    //     yield CheckCodeSuccesseded(user: result);
    //   } catch (e) {
    //     yield CheckCodeFailed(message: e.toString());
    //   }
    // }
    // if (event is RegisterNewUser) {
    //   yield RegisterInProgress(key: UniqueKey());
    //   try {
    //     final result = await authRepo.registerUser(
    //       user: event.updateUser.copyWith(
    //         phone: _sendCheckCode.phone,
    //       ),
    //     );
    //     if (result) {
    //       yield RegisterSuccesseded(key: UniqueKey());
    //     } else {
    //       yield RegisterFailed(message: result.toString(), key: UniqueKey());
    //     }
    //   } catch (e) {
    //     yield RegisterFailed(message: e.toString(), key: UniqueKey());
    //   }
    // }
    // if (event is StartLogOut) {
    //   yield LogOutInProgress();
    //   try {
    //     final result = await authRepo.logout();
    //     if (result) {
    //       yield LogOutSuccesseded();
    //     } else {
    //       yield LogOutFailed(message: "failed");
    //     }
    //   } catch (e) {
    //     yield LogOutFailed(message: e.toString());
    //   }
    // }
  }

  @override
  Future<void> close() {
    print("## AuthanticationBloc was Closed ##");
    return super.close();
  }
}

class PhoneNumberProvider extends ChangeNotifier {
  String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  set phoneNumber(String phoneNum) {
    _phoneNumber = phoneNum;
    notifyListeners();
  }
}
