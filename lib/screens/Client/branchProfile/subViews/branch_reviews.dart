import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Controllers/cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/client/custom_circle_avatar.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class BranchReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    Locale locale = BlocProvider.of<LocaleCubit>(context).state.locale;

    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, i) => Container(
          width: _size.width,
          padding: EdgeInsets.symmetric(
              vertical: KDefaultPadding / 2, horizontal: 5),
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
                      child: Text(
                        '18-5-2020',
                        style: _theme.textTheme.subtitle1,
                      )),
                  Wrap(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCircleAvatar(
                            height: 60,
                            width: 60,
                            image: null,
                          ),
                          HorizontalGap(width: KDefaultPadding / 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                      text: 'Car Wash ' + '\t|\t',
                                      style: _theme.textTheme.subtitle2,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '50 minuts ',
                                            style: _theme.textTheme.caption),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SmoothStarRating(
                                size: 12,
                                rating: 5.0,
                                isReadOnly: true,
                              ),
                              VerticalGap(
                                height: KDefaultPadding / 4,
                              ),
                              SizedBox(
                                width: _size.width * 0.6,
                                child: Text(
                                    ' world! world! world! world! world! world! world! world! world! world! world! world! world! world! world! world! world!',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: _theme.textTheme.caption),
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
        ),
      ),
    );
  }
}
