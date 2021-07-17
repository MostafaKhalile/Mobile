import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/offersBlocs/companyOffersBloc/companyoffers_bloc.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Widgets/client/company_offer_card.dart';
import 'package:techtime/Widgets/client/offer_card_body.dart';

class OffersScreen extends StatefulWidget {
  static const String routeName = "/Offers";
  @override
  OffersScreenState createState() => OffersScreenState();
}

class OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _translator.translate("offers"),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
      ),
      body: BlocBuilder<CompanyoffersBloc, CompanyoffersState>(
        builder: (context, state) {
          Widget widget;
          if (state is CompanyoffersSuccess) {
            widget = ListView.builder(
                padding: const EdgeInsets.all(
                  20,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (_, i) {
                  final compantOffer = state.companyOffers[i];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                          onTap: () {},
                          child: CompanyOfferCard(
                            height: 120,
                            child: OfferCardBody(
                              image: compantOffer.companyImage,
                              title: compantOffer.companyName,
                              subtitle:
                                  "${compantOffer.companyOffers.toString()}   ${" ${_translator.translate("offers")}"}",
                              hint: compantOffer.categoryEn,
                            ),
                          )));
                });
          }
          return widget;
        },
      ),
    );
  }
}
