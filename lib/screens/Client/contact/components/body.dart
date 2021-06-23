import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    ThemeData _theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: KdefaultPadding * 2),
            child: SvgPicture.asset("assets/svg/contact_us.svg"),
          ),
          VerticalGap(
            height: 40.0,
          ),
          Text(
            _translator.translate("need_help?"),
            style: _theme.textTheme.headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
          VerticalGap(),
          Text(
            _translator.translate("contact_us_via_customer_service"),
            style: _theme.textTheme.subtitle2,
          ),
          Padding(
            padding: EdgeInsets.only(top: KdefaultPadding * 2),
            child: Container(
              width: 170,
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () => whatsAppOpen(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      KWhatsAppAIcon,
                      color: KPrimaryColor,
                      height: 20,
                    ),
                    Text(
                      _translator.translate("start_chat"),
                      style: _theme.textTheme.button,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void whatsAppOpen() async {
    var whatsappUrl = "whatsapp://send?phone=+201276777241";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : launch(
            "https://wa.me/+201276777241/?text=hello",
          );
    // forceWebView: true,universalLinksOnly: true
  }
}
