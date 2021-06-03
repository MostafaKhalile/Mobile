import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class HeaderProfileAvatar extends StatelessWidget {
  final UserProfile userProfile;
  const HeaderProfileAvatar({
    Key key,
    this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircleAvatar(
              image: userProfile?.image ?? null,
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: KdefaultPadding,
            ),
            Text(
              userProfile?.firstName ?? KAppName,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
