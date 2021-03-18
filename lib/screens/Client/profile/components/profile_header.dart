import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';

class HeaderProfileAvatar extends StatelessWidget {
  const HeaderProfileAvatar({
    Key key,
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
              image: "https://via.placeholder.com/150",
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: KdefaultPadding,
            ),
            Text(
              "Mostafa Khalile",
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
