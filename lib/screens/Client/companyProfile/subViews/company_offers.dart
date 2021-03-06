import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyProfile/companyOffer/company_offer.dart';
import 'package:techtime/Models/client/companyProfile/company_profile.dart';
import 'package:techtime/Screens/Client/reservations/reservationFirstStep/reservation_first_step.dart';

class CompanyOffers extends StatefulWidget {
  final CompanyProfile companyProfile;

  const CompanyOffers({Key? key, required this.companyProfile})
      : super(key: key);

  @override
  CompanyOffersState createState() => CompanyOffersState();
}

class CompanyOffersState extends State<CompanyOffers> {
  List<CompanyOfferInfo> _checked = [];
  final customController = CustomGroupController(
    isMultipleSelection: true,
  );
  GroupController controller = GroupController();

  @override
  void initState() {
    customController.listen((value) {
      print(value);
      _checked =
          (value as List).map((item) => item as CompanyOfferInfo).toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations? _translator = AppLocalizations.of(context);
    if (widget.companyProfile.companyOffers!.isNotEmpty) {
      return Scaffold(
        body: SizedBox(
            width: _size.width,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Column(children: <Widget>[
                      SizedBox(
                          height: _size.height,
                          child: CustomGroupedCheckbox<CompanyOfferInfo>(
                              controller: customController,
                              isScroll: true,
                              values: widget.companyProfile.companyOffers!,
                              itemBuilder: (ctx, index, selected, isDisabled) {
                                return OfferCard(
                                  cb: Checkbox(
                                    value: selected,
                                    checkColor: Colors.black,
                                    activeColor: AppColors.primaryColor,
                                    onChanged: (value) {
                                      selected = value;
                                    },
                                  ),
                                  companyOffer: widget
                                      .companyProfile.companyOffers![index],
                                );
                              }))
                    ])))),
        persistentFooterButtons: [
          SizedBox(
            width: _size.width,
            child: Row(
              children: [
                Expanded(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () => _bookHandler(),
                  disabledColor: Colors.black38,
                  child: Text(
                    _translator!.translate("book_now")!,
                    style: Theme.of(context).textTheme.button,
                  ),
                ))
              ],
            ),
          )
        ],
      );
    } else {
      return SizedBox(
          width: _size.width,
          height: _size.height,
          child: Center(
              child: Text(
            _translator!.translate("no_offers")!,
            style: _theme.textTheme.subtitle2,
          )));
    }
  }

  void _bookHandler() {
    _checked.isNotEmpty
        ? Navigator.pushNamed(context, ReservationFirstStep.routeName,
            arguments: {
                "ReservationType": ReservationType.offer,
                "branchID": widget.companyProfile.companyOffers?[0].branchId
              })
        : Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!
                .translate("please_select_service_first")!);
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    this.cb,
    this.companyOffer,
  }) : super(key: key);

  final Widget? cb;
  final CompanyOfferInfo? companyOffer;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    return Card(
      child: SizedBox(
        width: _size.width * .9,
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (companyOffer?.offerImage != null)
                            ? NetworkImage(NetworkConstants.baseUrl +
                                companyOffer!.offerImage!) as ImageProvider
                            : const AssetImage(placeHolderImage)),
                    borderRadius: BorderRadius.circular(defaultRadius)),
              ),
              title: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            text: "${companyOffer!.offerName}\n",
                            style: _theme.textTheme.subtitle2,
                          ),
                        ),
                      ),
                      Expanded(
                          child: RichText(
                        overflow: TextOverflow.visible,
                        text: TextSpan(
                          text:
                              '${companyOffer!.price}  ${_translator.translate('EGP')}' +
                                  "\n",
                          style: _theme.textTheme.caption,
                          children: <TextSpan>[
                            TextSpan(
                                text: '${companyOffer!.fullTime} minutes',
                                style: _theme.textTheme.caption),
                          ],
                        ),
                      )),
                    ],
                  ),
                ],
              ),
              subtitle: Text(companyOffer!.offerName!,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                  style: _theme.textTheme.caption),
              isThreeLine: true,
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: 5.0,
              trailing: cb ?? Container(),
            ),
          ],
        ),
      ),
    );
  }
}
