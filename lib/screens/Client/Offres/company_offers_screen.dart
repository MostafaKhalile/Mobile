import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/offersBlocs/filterCompanyOffersBloc/filtercompanyoffers_bloc.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/offers/company_offer.dart';
import 'package:techtime/Models/client/offers/company_offers.dart';
import 'package:techtime/Screens/Client/reservations/reservationFirstStep/reservation_first_step.dart';
import 'package:techtime/Widgets/core/horizontal_gap.dart';
import 'package:techtime/Widgets/core/service_info_card.dart';
import 'package:techtime/Widgets/core/shimmer_effect.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

class CompanyOffersScreen extends StatefulWidget {
  static const String routeName = "/CompanyOffers";
  final CompanyDataOffer? companyOffer;
  const CompanyOffersScreen({
    Key? key,
    required this.companyOffer,
  }) : super(key: key);

  @override
  _CompanyOffersScreenState createState() => _CompanyOffersScreenState();
}

class _CompanyOffersScreenState extends State<CompanyOffersScreen> {
  @override
  void initState() {
    BlocProvider.of<FiltercompanyoffersBloc>(context)
        .add(FilterCompanyOffers(widget.companyOffer!.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _translator.translate("offers")!,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      ),
      body: BlocBuilder<FiltercompanyoffersBloc, FiltercompanyoffersState>(
        builder: (context, state) {
          Widget widget;
          if (state is FiltercompanyoffersSuccess) {
            widget = ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (cntx, i) => OfferCard(
                      onPress: () => _bottomSheet(
                          context, state.companyOffers.companyOffers![i]),
                      companyOffer: state.companyOffers.companyOffers![i],
                    ),
                separatorBuilder: (cntx, i) => const VerticalGap(),
                itemCount: state.companyOffers.companyOffers!.length);
          } else {
            widget = const CompanyOffersLoading();
          }

          return widget;
        },
      ),
    );
  }

  Future _bottomSheet(BuildContext context, CompanyOffer companyOffer) async {
    showModalBottomSheet(
        context: context,
        elevation: 16.0,
        isScrollControlled: false,
        enableDrag: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(defaultRadius),
        //       topRight: Radius.circular(defaultRadius)),
        // ),
        builder: (context) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CloseButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    companyOffer.offerName ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                      AppLocalizations.of(context)!
                          .translate("offer_services_details")!,
                      style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: companyOffer.allServices!.length,
                  separatorBuilder: (_, i) => const VerticalGap(),
                  itemBuilder: (context, i) => ServiceInfoCard(
                    service: companyOffer.allServices![i],
                  ),
                ),
              ),
            ],
          );
        }).then((value) => {print("closed")});
  }
}

class CompanyOffersLoading extends StatelessWidget {
  const CompanyOffersLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (cntx, i) => const OfferCard(),
          separatorBuilder: (cntx, i) => const VerticalGap(),
          itemCount: 5),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    this.companyOffer,
    this.onPress,
  }) : super(key: key);
  final CompanyOffer? companyOffer;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations _translator = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onPress,
      child: Card(
        elevation: 1.0,
        color: _theme.scaffoldBackgroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: _size.width * .9,
          child: ListTile(
            minVerticalPadding: 2,
            isThreeLine: true,
            dense: false,
            horizontalTitleGap: 10.0,
            contentPadding: const EdgeInsets.all(10),
            leading: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: (companyOffer?.offerImage != null)
                          ? NetworkImage(NetworkConstants.baseUrl +
                              companyOffer!.offerImage!) as ImageProvider
                          : const AssetImage(placeHolderImage)),
                  borderRadius: BorderRadius.circular(defaultRadius)),
            ),
            title: Text(companyOffer?.offerName ?? '',
                style: _theme.textTheme.subtitle2),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text("${companyOffer?.fullTime ?? ''} minutes",
                      overflow: TextOverflow.visible,
                      style: _theme.textTheme.caption),
                  const HorizontalGap(),
                  Text(
                      "${companyOffer?.allServices?.length ?? ""} ${_translator.translate("service")}",
                      overflow: TextOverflow.visible,
                      style: _theme.textTheme.caption),
                ]),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${companyOffer?.price ?? ""}  ${_translator.translate("EGP")}",
                  style: _theme.textTheme.subtitle1,
                ),
              ],
            ),
            trailing: Column(
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => Navigator.pushNamed(
                      context, ReservationFirstStep.routeName, arguments: {
                    "ReservationType": ReservationType.offer,
                    "branchID": companyOffer!.branchId
                  }),
                  disabledColor: Colors.black38,
                  child: Text(
                    _translator.translate("book_now")!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
