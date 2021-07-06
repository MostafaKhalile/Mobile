import 'package:flutter/material.dart';
import 'package:techtime/Helpers/app_colors.dart';

class WalletInputField extends StatelessWidget {
  const WalletInputField({
    Key key,
    @required ThemeData theme,
    this.hintText,
    @required this.controller,
    @required this.keyboardType,
  })  : _theme = theme,
        super(key: key);

  final ThemeData _theme;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      cursorColor: AppColors.primaryColor,
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
