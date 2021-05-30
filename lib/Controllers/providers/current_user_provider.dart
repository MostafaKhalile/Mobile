import 'package:flutter/foundation.dart';

import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/models/user.dart';

class CurrentUserProvider extends ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();
  User _user;
  User get currentUser => _user;
  User loadCurrentUser() {
    try {
      _user = _authRepo.currentUser;
      notifyListeners();
      return _user;
    } catch (e) {
      print("ERROR $e");
      return null;
    }
  }
}
