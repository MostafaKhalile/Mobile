import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/sub_title.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class ReservationControllersView extends StatelessWidget {
  const ReservationControllersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: const <Widget>[FinishedOrderControlls()],
    );
  }
}

class FinishedOrderControlls extends StatelessWidget {
  const FinishedOrderControlls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? _translator = AppLocalizations.of(context);
    final ThemeData _theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SubTitle(
            text: _translator!.translate("payment")!,
          ),
          const WithdrawFromWalletToOrderWidget(),
          const PromoCodeToOrderWidget(),
          SubTitle(
            text: _translator.translate("reviews")!,
          ),
          Column(
            children: [
              RatingIndecatorWithTitle(
                title: _translator.translate("company")!,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingIndecatorWithTitle(
                title: _translator.translate("branch")!,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingIndecatorWithTitle(
                title: _translator.translate("the_service")!,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              RatingIndecatorWithTitle(
                title: _translator.translate("staff")!,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: _translator.translate('add_comment'),
                      filled: true,
                      fillColor: Colors.white,
                    )),
              ),
              Center(
                // ignore: deprecated_member_use
                child: RaisedButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    child: Text(
                      _translator.translate("end_order")!,
                      style: _theme.textTheme.bodyText2!
                          .copyWith(color: _theme.scaffoldBackgroundColor),
                    )),
              ),
              const VerticalGap()
            ],
          )
        ],
      ),
    );
  }
}

class RatingIndecatorWithTitle extends StatelessWidget {
  const RatingIndecatorWithTitle({
    Key? key,
    required this.title,
    required this.onRatingUpdate,
  }) : super(key: key);
  final String title;
  final Function(double) onRatingUpdate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
          RatingBar.builder(
            minRating: 1,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemSize: 18,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onRatingUpdate,
          )
        ],
      ),
    );
  }
}

class PromoCodeToOrderWidget extends StatelessWidget {
  const PromoCodeToOrderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations? _translator = AppLocalizations.of(context);
    final ThemeData _appTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/promocode.svg",
            height: 25,
            color: AppColors.primaryColor,
          ),
          const HorizontalGap(),
          SizedBox(
            width: _size.width * 0.5,
            child: TextField(
              keyboardType: TextInputType.number,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: _translator!.translate('Enter_the_promo_code'),
                  hintStyle: _appTheme.textTheme.caption!
                      .copyWith(color: Colors.black)),
            ),
          ),
          const HorizontalGap(),
          // ignore: deprecated_member_use
          RaisedButton(
            padding: const EdgeInsets.all(10),
            onPressed: () => {},
            disabledColor: Colors.black38,
            child: Text(
              _translator.translate("confirm")!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}

class WithdrawFromWalletToOrderWidget extends StatelessWidget {
  const WithdrawFromWalletToOrderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations? _translator = AppLocalizations.of(context);
    final ThemeData _appTheme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/wallet.svg",
            height: 25,
            color: AppColors.primaryColor,
          ),
          const HorizontalGap(),
          SizedBox(
            width: _size.width * 0.5,
            child: TextField(
              keyboardType: TextInputType.number,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
              decoration: InputDecoration(
                  suffixText: _translator!.translate('EGP'),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: AppLocalizations.of(context)!
                      .translate('withdraw_from_wallet'),
                  hintStyle: _appTheme.textTheme.caption!
                      .copyWith(color: Colors.black)),
            ),
          ),
          const HorizontalGap(),
          // ignore: deprecated_member_use
          RaisedButton(
            padding: const EdgeInsets.all(10),
            onPressed: () => {},
            disabledColor: Colors.black38,
            child: Text(
              _translator.translate("confirm")!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
