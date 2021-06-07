import 'package:flutter/material.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/screens/Client/profile/components/profile_controls.dart';

import 'components/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile _userProfile;
  USerRepo _userRepo = USerRepo();
  @override
  void initState() {
    _userProfile = _userRepo.currentUserProfile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            HeaderProfileAvatar(
              userProfile: _userProfile,
            ),
            ProfileControls()
          ],
        ),
      ),
    );
  }
}
