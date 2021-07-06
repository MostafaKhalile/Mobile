import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client/companyProfile/companyReviews/company_reviews.dart';
import 'package:techtime/Widgets/client/review_card.dart';

class CompanyReviewsScreen extends StatelessWidget {
  final CompanyReviews reviews;

  const CompanyReviewsScreen({Key key, this.reviews}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    // Locale locale = BlocProvider.of<LocaleCubit>(context).state.locale;

    if (reviews.companyReviews.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: reviews.companyReviews.length,
          itemBuilder: (context, i) => SizedBox(
            width: _size.width,
            child: ReviewCard(
              review: reviews.companyReviews[i],
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        child: Column(
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
}
