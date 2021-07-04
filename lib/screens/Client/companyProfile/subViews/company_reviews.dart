import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client/companyProfile/companyReviews/company_reviews.dart';
import 'package:techtime/Widgets/client/review_card.dart';

class CompanyReviewsScreen extends StatelessWidget {
  final CompanyReviews reviews;

  const CompanyReviewsScreen({Key key, this.reviews}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    // Locale locale = BlocProvider.of<LocaleCubit>(context).state.locale;

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
