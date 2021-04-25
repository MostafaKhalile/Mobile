import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    Key key,
    @required ThemeData theme,
    @required this.controller,
    this.enabled,
  })  : _theme = theme,
        super(key: key);

  final TextEditingController controller;
  final ThemeData _theme;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    AppLocalizations _translator = AppLocalizations.of(context);
    return Column(
      children: [
        Row(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(
                controller: controller,
                enabled: enabled,
                cursorColor: KPrimaryColor,
                style: _theme.textTheme.caption.copyWith(
                    fontWeight: FontWeight.bold, color: _theme.accentColor),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 0, left: 30, right: 30),
                    hintStyle: _theme.textTheme.caption.copyWith(
                        fontWeight: FontWeight.bold, color: _theme.accentColor),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                _translator.translate("update"),
                style: _theme.textTheme.button.copyWith(fontSize: 12),
              ))
        ]),
        Divider(
          height: KDefaultPadding / 2,
          color: Colors.white,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
