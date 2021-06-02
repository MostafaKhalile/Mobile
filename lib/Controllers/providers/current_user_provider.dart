import 'package:flutter/foundation.dart';

import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Models/client_profile.dart';

class CurrentUserProvider extends ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();
  UserProfile _userData;
  UserProfile get currentUser => _userData;
  UserProfile loadCurrentUser() {
    try {
      _userData = _authRepo.currentUserProfile;
      notifyListeners();
      return _userData;
    } catch (e) {
      print("ERROR $e");
      return null;
    }
  }
}
