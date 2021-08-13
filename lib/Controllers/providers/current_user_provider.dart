import 'package:flutter/material.dart';

import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Models/client_profile.dart';

class CurrentUserProvider extends ChangeNotifier {
  final USerRepo _userRepo = USerRepo();
  UserProfile? _user;
  UserProfile? _userData;
  UserProfile? get currentUser => _userData;
  UserProfile? loadCurrentUser() {
    try {
      _userData = _userRepo.currentUserProfile;
   
      notifyListeners();
      return _user;
    } catch (e) {
      print("ERROR $e");
      return null;
    }
  }
}
