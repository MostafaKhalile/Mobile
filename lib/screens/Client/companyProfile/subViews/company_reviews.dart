import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Controllers/Cubits/LocaleCubit/locale_cubit.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client/companyProfile/companyReviews/company_reviews.dart';
import 'package:techtime/Widgets/client/review_card.dart';
// import 'package:techtime/widgets/client/custom_circle_avatar.dart';
// import 'package:techtime/widgets/core/horizontal_gap.dart';
// import 'package:techtime/widgets/core/vertical_gab.dart';

class CompanyReviewsScreen extends StatelessWidget {
  final CompanyReviews reviews;

  const CompanyReviewsScreen({Key key, this.reviews}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    Locale locale = BlocProvider.of<LocaleCubit>(context).state.locale;

    return reviews.companyReviews.length > 0
        ? SizedBox(
            width: double.infinity,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: reviews.companyReviews.length,
              itemBuilder: (context, i) => Container(
                width: _size.width,
                child: ReviewCard(
                  review: reviews.companyReviews[i],
                ),
              ),
            ),
          )
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SvgPicture.asset("assets/svg/NoMessages.svg"),
                Text(
                  _translator.translate("no_reviews"),
                  style: _theme.textTheme.subtitle1,
                )
              ],
            ),
          );
  }
}
