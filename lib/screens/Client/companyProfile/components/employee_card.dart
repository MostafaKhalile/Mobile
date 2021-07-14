import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomCircleAvatar(
          height: 60,
          width: 60,
          image: null,
        ),
        const VerticalGap(height: defaultPadding / 2),
        const Text("name"),
        const VerticalGap(height: defaultPadding / 2),
        RatingBarIndicator(
          rating: 5.00,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 50.0,
        ),
      ],
    );
  }
}
