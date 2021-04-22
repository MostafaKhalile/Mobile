import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';

class WalletInputField extends StatelessWidget {
  const WalletInputField({
    Key key,
    @required ThemeData theme,
    this.hintText,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      cursorColor: KPrimaryColor,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: _theme.textTheme.headline3
              .copyWith(fontWeight: FontWeight.bold, color: _theme.accentColor),
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none),
      style: _theme.textTheme.headline3
          .copyWith(fontWeight: FontWeight.bold, color: _theme.accentColor),
    );
  }
}
