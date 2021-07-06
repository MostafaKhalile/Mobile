import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheReviews/reviews.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    this.review,
  }) : super(key: key);

  final Review review;
  @override
  Widget build(BuildContext context) {
    final Locale locale = BlocProvider.of<LocaleCubit>(context).state.locale;
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return SizedBox(
      width: _size.width * 0.7,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                  alignment: locale == const Locale('ar')
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: (review != null)
                      ? Text(
                          review.date,
                          style: _theme.textTheme.subtitle1,
                        )
                      : Container(
                          height: 10,
                          width: 30,
                          color: Colors.white,
                        )),
              Wrap(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: (review != null)
                              ? (review.image != null)
                                  ? Image.network(
                                      NetworkConstants.baseUrl +
                                          (review.image as String),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(placeHolderImage)
                              : Container(),
                        ),
                      ),
                      const HorizontalGap(width: defaultPadding / 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (review != null)
                                Text(
                                  review.name,
                                  style: _theme.textTheme.subtitle2,
                                )
                              else
                                Container(),
                            ],
                          ),
                          if (review != null)
                            SmoothStarRating(
                              size: 14,
                              rating: double.parse(review.raty.toString()),
                              isReadOnly: true,
                            )
                          else
                            Container(),
                          const VerticalGap(
                            height: defaultPadding,
                          ),
                          SizedBox(
                            width: _size.width * 0.4,
                            child: (review != null)
                                ? Text(review.comment,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: _theme.textTheme.caption)
                                : Container(),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
