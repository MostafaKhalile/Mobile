import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:techtime/Helpers/api_urls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client/companyProfile/companyOffer/company_offer.dart';
import 'package:techtime/Models/client/companyProfile/company_profile.dart';
import 'package:techtime/Screens/Client/booking/orderFirstStep/order_first_step.dart';

class CompanyOffers extends StatefulWidget {
  final CompanyProfile companyProfile;

  const CompanyOffers({Key key, @required this.companyProfile})
      : super(key: key);

  @override
  CompanyOffersState createState() => CompanyOffersState();
}

class CompanyOffersState extends State<CompanyOffers> {
  List<String> _checked = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    if (widget.companyProfile.companyOffers.isNotEmpty) {
      return Scaffold(
        body: SizedBox(
            width: _size.width,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: KdefaultPadding),
                    child: Column(children: <Widget>[
                      CheckboxGroup(
                        activeColor: KPrimaryColor,
                        checkColor: _theme.primaryColorDark,
                        // ignore: avoid_redundant_argument_values
                        orientation: GroupedButtonsOrientation.VERTICAL,
                        onSelected: (List selected) => setState(() {
                          _checked = selected as List<String>;
                          print(_checked);
                        }),
                        labels:
                            widget.companyProfile.companyOffers.map((element) {
                          return element.toJson().toString();
                        }).toList(),
                        checked: _checked,
                        itemBuilder: (Checkbox cb, Text txt, int i) {
                          return OfferCard(
                            cb: cb,
                            companyOffer:
                                widget.companyProfile.companyOffers[i],
                          );
                        },
                      ),
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
                    _translator.translate("book_now"),
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
            _translator.translate("no_offers"),
            style: _theme.textTheme.subtitle2,
          )));
    }
  }

  void _bookHandler() {
    _checked.isNotEmpty
        ? Navigator.pushNamed(context, OrderFirstStep.routeName,
            arguments: widget.companyProfile.companyBranches)
        : Fluttertoast.showToast(
            msg: AppLocalizations.of(context)
                .translate("please_select_service_first"));
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key key,
    this.cb,
    this.companyOffer,
  }) : super(key: key);

  final Checkbox cb;
  final CompanyOffer companyOffer;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Stack(
      children: [
        Card(
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
                                ? NetworkImage(
                                        KAPIURL + companyOffer.offerImage)
                                    as ImageProvider
                                : const AssetImage(KPlaceHolderImage)),
                        borderRadius: BorderRadius.circular(KdefaultRadius)),
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
                                text: "${companyOffer.offerName}\n",
                                style: _theme.textTheme.subtitle2,
                              ),
                            ),
                          ),
                          Expanded(
                              child: RichText(
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              text:
                                  '${companyOffer.price}  ${_translator.translate('EGP')}' +
                                      "\n",
                              style: _theme.textTheme.caption,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${companyOffer.fullTime} minutes',
                                    style: _theme.textTheme.caption),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(companyOffer.offerName,
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
        ),
      ],
    );
  }
}
