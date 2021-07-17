import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/companyProfile/company_profile.dart';
import 'package:techtime/Models/client/companyProfile/company_service.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Screens/Client/reservations/reservationFirstStep/reservation_first_step.dart';

class CompanyServices extends StatefulWidget {
  final CompanyProfile companyProfile;

  const CompanyServices({Key key, @required this.companyProfile})
      : super(key: key);

  @override
  CompanyServicesState createState() => CompanyServicesState();
}

class CompanyServicesState extends State<CompanyServices> {
  List<String> _checked = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    final _currentUser = Provider.of<CurrentUserProvider>(context).currentUser;

    final AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      body: SizedBox(
          width: _size.width,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(children: <Widget>[
                  CheckboxGroup(
                    activeColor: AppColors.primaryColor,
                    checkColor: _theme.primaryColorDark,
                    onSelected: (List selected) => setState(() {
                      _checked = selected as List<String>;
                      print(_checked);
                    }),
                    labels:
                        widget.companyProfile.companyServices.map((element) {
                      return element.toJson().toString();
                    }).toList(),
                    checked: _checked,
                    itemBuilder: (Checkbox cb, Text txt, int i) {
                      return ServiceCard(
                        cb: cb,
                        companyService:
                            widget.companyProfile.companyServices[i],
                      );
                    },
                  ),
                ]),
              ))),
      persistentFooterButtons: [
        SizedBox(
          width: _size.width,
          child: Row(
            children: [
              Expanded(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                padding: const EdgeInsets.all(10),
                onPressed: () => _bookHandler(_currentUser),
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
  }

  void _bookHandler(UserProfile _currentUser) {
    if (_currentUser != null) {
      _checked.isNotEmpty
          ? Navigator.pushNamed(context, ReservationFirstStep.routeName,
              arguments: widget.companyProfile.companyBranches)
          : Fluttertoast.showToast(
              msg: AppLocalizations.of(context)
                  .translate("please_select_service_first"));
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate("please_login_first"));
    }
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key key,
    this.cb,
    this.companyService,
  }) : super(key: key);

  final Checkbox cb;
  final CompanyService companyService;

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
                            image: (companyService?.image != null)
                                ? NetworkImage(NetworkConstants.baseUrl +
                                    companyService.image) as ImageProvider
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
                                text: "${companyService.nameServicesAr}\n",
                                style: _theme.textTheme.subtitle2,
                              ),
                            ),
                          ),
                          Expanded(
                              child: RichText(
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              text:
                                  '${companyService.priceFrom} - ${companyService.priceTo} ${_translator.translate('EGP')}' +
                                      "\n",
                              style: _theme.textTheme.caption,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${companyService.fullTime} minutes',
                                    style: _theme.textTheme.caption),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(companyService.description,
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
