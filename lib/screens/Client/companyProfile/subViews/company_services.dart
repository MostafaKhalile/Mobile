import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/models/client/companyProfile/company_branches.dart';
import 'package:techtime/screens/Client/newOrder/create_new_order.dart';

import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class CompanyServices extends StatefulWidget {
  final List<CompanyBranches> companyBranches;

  const CompanyServices({Key key, @required this.companyBranches})
      : super(key: key);

  @override
  CompanyServicesState createState() => CompanyServicesState();
}

class CompanyServicesState extends State<CompanyServices> {
  List<String> _checked = [];
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    // AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
          width: _size.width,
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: <Widget>[
                CheckboxGroup(
                  activeColor: KPrimaryColor,
                  checkColor: _theme.primaryColorDark,
                  orientation: GroupedButtonsOrientation.VERTICAL,
                  onSelected: (List selected) => setState(() {
                    _checked = selected;
                  }),
                  labels: <String>["A", "B", "c", "D"],
                  checked: _checked,
                  itemBuilder: (Checkbox cb, Text txt, int i) {
                    return Card(
                      elevation: 10,
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                margin: EdgeInsets.all(KDefaultPadding / 4),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(KPlaceHolderImage)),
                                    borderRadius:
                                        BorderRadius.circular(KdefaultRadius)),
                              ),
                              HorizontalGap(width: KDefaultPadding / 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(
                                          text: 'Car Wash ' + "\n",
                                          style: _theme.textTheme.headline6,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '50 minuts ',
                                                style:
                                                    _theme.textTheme.caption),
                                          ],
                                        ),
                                      ),
                                      HorizontalGap(
                                        width: KdefaultPadding * 1.5,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(
                                          text: '150 - 100 EGP' + "\n",
                                          style: _theme.textTheme.subtitle1,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '200',
                                                style: _theme
                                                    .textTheme.subtitle2
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor:
                                                            KErrorColor)),
                                            TextSpan(
                                                text: '\t \t EGP',
                                                style: _theme.textTheme.caption)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalGap(
                                    height: KDefaultPadding / 4,
                                  ),
                                  SizedBox(
                                    width: _size.width * 0.55,
                                    child: Text(
                                        ' world! world! world! world! world! world! world! world! world! world! world! world! world! world! world! world! world!',
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        style: _theme.textTheme.caption),
                                  ),
                                ],
                              ),
                              // Spacer(),
                              cb
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ]))),
      persistentFooterButtons: [
        Container(
          width: _size.width,
          child: Row(
            children: [
              Expanded(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                padding: EdgeInsets.all(10),
                onPressed: () => _bookHandler(),
                disabledColor: Colors.black38,
                child: Text(
                  "Book Now",
                  style: Theme.of(context).textTheme.button,
                ),
              ))
            ],
          ),
        )
      ],
    );
  }

  _bookHandler() {
    _checked.length != 0
        ? Navigator.pushNamed(context, CreateNewOrder.routeName,
            arguments: widget.companyBranches)
        : Fluttertoast.showToast(
            msg: AppLocalizations.of(context)
                .translate("please_select_service_first"));
  }
}
