import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class HeaderProfileAvatar extends StatelessWidget {
  final UserProfile? userProfile;
  const HeaderProfileAvatar({
    Key? key,
    this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<CurrentUserProvider>(context).currentUser;
    return Expanded(
      flex: 2,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircleAvatar(
              image: _currentUser?.image,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              _currentUser?.firstName ?? NetworkConstants.appName,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
