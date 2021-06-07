import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/validation.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';
import 'package:techtime/screens/Core/startupViews/emailForgetPassworProcess/email_confirm_code.dart';

class EditPasswordScreen extends StatefulWidget {
  static const String routeName = "/email_confirm_code";

  @override
  _EditPasswordScreen createState() => _EditPasswordScreen();
}

class _EditPasswordScreen extends State<EditPasswordScreen> {
  bool _obscureText = true;

  Validator _validator = Validator();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);

    ThemeData _theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: SizedBox(
          width: _size.width,
          height: _size.height * 0.7,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  VerticalGap(),
                  SvgPicture.asset(KShieldIcon),
                  // VerticalGap(),
                  Padding(
                    padding: const EdgeInsets.all(KdefaultPadding),
                    child: Text(
                      _translator.translate("reset_password"),
                      style: _theme.textTheme.subtitle2,
                    ),
                  ),
                  Container(
                      width: _size.width * .7,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) =>
                                _emailController.text = newValue,
                            style: _theme.textTheme.bodyText1
                                .copyWith(color: KDarkGreyColor),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: _translator.translate("old_password"),
                                hintStyle: _theme.textTheme.caption
                                    .copyWith(color: KDarkGreyColor),
                                contentPadding: EdgeInsets.only(
                                    bottom: 5, right: 8, left: 8),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                          VerticalGap(),
                          TextField(
                              obscureText: _obscureText,
                              style: _theme.textTheme.bodyText1
                                  .copyWith(color: KDarkGreyColor),
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: _translator.translate("password"),
                                  hintStyle: _theme.textTheme.caption
                                      .copyWith(color: KDarkGreyColor),
                                  suffixIcon: IconButton(
                                    onPressed: () => _toggle(),
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: KdefaultPadding / 2,
                                      horizontal: KdefaultPadding / 2),
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none)),
                          VerticalGap(),
                          TextField(
                              obscureText: _obscureText,
                              style: _theme.textTheme.bodyText1
                                  .copyWith(color: KDarkGreyColor),
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: _translator.translate("Repassword"),
                                  suffixIcon: IconButton(
                                    onPressed: () => _toggle(),
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintStyle: _theme.textTheme.caption
                                      .copyWith(color: KDarkGreyColor),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: KdefaultPadding / 2,
                                      horizontal: KdefaultPadding / 2),
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none)),
                        ],
                      )),

                  Padding(
                    padding: EdgeInsets.only(top: KdefaultPadding * 2),
                    child: Container(
                      width: 170,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }
                          },
                          color: KPrimaryColor,
                          child: Text(
                            _translator.translate("confirm"),
                            style: _theme.textTheme.button.copyWith(
                                color: _theme.scaffoldBackgroundColor),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
