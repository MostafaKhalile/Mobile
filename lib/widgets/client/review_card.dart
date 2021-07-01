import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
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
    Locale locale = BlocProvider.of<LocaleCubit>(context).state.locale;
    Size _size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);
    return Container(
      width: _size.width * 0.7,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                  alignment: locale == Locale('ar')
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
                                      KAPIURL + review.image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(KPlaceHolderImage)
                              : Container(),
                        ),
                      ),
                      HorizontalGap(width: KDefaultPadding / 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (review != null)
                                  ? Text(
                                      review.name,
                                      style: _theme.textTheme.subtitle2,
                                    )
                                  : Container(),
                            ],
                          ),
                          (review != null)
                              ? RatingBarIndicator(
                                  rating: 5.00,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 14.0,
                                  direction: Axis.horizontal,
                                )
                              : Container(),
                          VerticalGap(
                            height: KDefaultPadding,
                          ),
                          SizedBox(
                            width: _size.width * 0.4,
                            child: (review != null)
                                ? Text('''${review.comment}''',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: _theme.textTheme.caption)
                                : Container(),
                          ),
                        ],
                      ),
                      Spacer(),
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
