import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/network_constants.dart';
import 'package:techtime/Models/client/offers/company_offers.dart';

class ServiceInfoCard extends StatelessWidget {
  const ServiceInfoCard({
    Key key,
    this.service,
  }) : super(key: key);
  final Service service;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations _translator = AppLocalizations.of(context);
    return Card(
        color: _theme.scaffoldBackgroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
            width: _size.width * .85,
            child: Wrap(children: <Widget>[
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (service?.imageService != null)
                              ? NetworkImage(NetworkConstants.baseUrl +
                                  service?.imageService) as ImageProvider
                              : const AssetImage(placeHolderImage)),
                      borderRadius: BorderRadius.circular(defaultRadius)),
                ),
                title: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: service.servicesNameAr,
                          style: _theme.textTheme.subtitle2,
                        ),
                      ),
                    ),
                  ])
                ]),
                subtitle: SizedBox(
                  width: _size.width * 0.15,
                  child: Text(service.servicesDescription,
                      overflow: TextOverflow.clip,
                      // textAlign: TextAlign.justify,
                      // maxLines: 4,
                      style: _theme.textTheme.caption),
                ),
                trailing: Column(children: [
                  Text(
                    '${service.servicesPriceFrom} - ${service.servicesPriceTo} ${_translator.translate('EGP')}',
                    style: _theme.textTheme.caption,
                  ),
                  Text(
                    '${service.servicesFullTime} ${_translator.translate('minute')}',
                    style: _theme.textTheme.caption,
                  ),
                ]),
                // isThreeLine: true,
                contentPadding: const EdgeInsets.all(10),
                horizontalTitleGap: 5.0,
              ),
            ])));
  }
}
