import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techtime/Controllers/BLoCs/client/companyDataBlobs/bloc/companyservices_bloc.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client/companyData/company_service.dart';
import 'package:techtime/models/client/companyProfile/company_branches.dart';
import 'package:techtime/screens/Client/newOrder/create_new_order.dart';

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
  void initState() {
    BlocProvider.of<CompanyservicesBloc>(context)
        .add(GetCompanyServices(widget.companyBranches[0].brancheID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    // AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      body: BlocConsumer<CompanyservicesBloc, CompanyservicesState>(
        listener: (context, state) {
          if (state is CompanyservicesFaild) {
            print(state.message);
          }
        },
        builder: (context, state) {
          if (state is CompanyservicesSuccess) {
            return Container(
                width: _size.width,
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: KdefaultPadding),
                      child: Column(children: <Widget>[
                        CheckboxGroup(
                          activeColor: KPrimaryColor,
                          checkColor: _theme.primaryColorDark,
                          orientation: GroupedButtonsOrientation.VERTICAL,
                          onSelected: (List selected) => setState(() {
                            _checked = selected;
                            print(_checked);
                          }),
                          labels: state.services.map((element) {
                            return element.toJson().toString();
                          }).toList(),
                          checked: _checked,
                          itemBuilder: (Checkbox cb, Text txt, int i) {
                            return ServiceCard(
                              cb: cb,
                              companyService: state.services[i],
                            );
                          },
                        ),
                      ]),
                    )));
          }
          if (state is CompanyservicesLoading ||
              state is CompanyservicesFaild) {
            return ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(KdefaultPadding),
              itemBuilder: (context, i) => Shimmer.fromColors(
                  baseColor: _theme.highlightColor,
                  highlightColor: _theme.hoverColor.withOpacity(0.2),
                  direction: ShimmerDirection.ltr,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 100,
                    width: _size.width,
                    color: Colors.white,
                  )),
            );
          }
          return Container();
        },
      ),
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
          child: Container(
            width: _size.width * .9,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (companyService?.image != null)
                                ? NetworkImage(KAPIURL + companyService.image)
                                : AssetImage(KPlaceHolderImage)),
                        borderRadius: BorderRadius.circular(KdefaultRadius)),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: RichText(
                              overflow: TextOverflow.clip,
                              text: TextSpan(
                                text: companyService.nameServicesAr + "\n",
                                style: _theme.textTheme.subtitle2,
                                // children: <TextSpan>[
                                //   TextSpan(
                                //       text:
                                //           '${companyService.fullTime} minutes',
                                //       style: _theme.textTheme.caption),
                                // ],
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
                      maxLines: 4,
                      style: _theme.textTheme.caption),
                  isThreeLine: true,
                  contentPadding: EdgeInsets.all(0),
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
