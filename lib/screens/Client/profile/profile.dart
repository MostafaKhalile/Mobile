import 'package:flutter/material.dart';
import 'package:techtime/screens/Client/profile/components/profile_controls.dart';

import 'components/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[HeaderProfileAvatar(), ProfileControls()],
        ),
      ),
    );
  }
}
