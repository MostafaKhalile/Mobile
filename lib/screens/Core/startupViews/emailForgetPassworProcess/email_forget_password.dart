import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/validation.dart';
import 'package:techtime/screens/Core/startupViews/emailForgetPassworProcess/email_confirm_code.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class EmailForgetPassword extends StatefulWidget {
  static const String routeName = "/email_confirm_code";

  @override
  _EmailForgetPasswordState createState() => _EmailForgetPasswordState();
}

class _EmailForgetPasswordState extends State<EmailForgetPassword> {
  Validator _validator = Validator();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);

    ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          _translator.translate("forgotPassword"),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
            width: _size.width,
            height: _size.height,
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: KdefaultPadding * 2),
                        child: Text(
                          _translator.translate("forgotPassword"),
                          style: _theme.textTheme.headline5
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    VerticalGap(),
                    SvgPicture.asset(KContactUsIcon),
                    // VerticalGap(),
                    Padding(
                      padding: const EdgeInsets.all(KdefaultPadding),
                      child: Text(
                        _translator.translate("enter_your_email"),
                        style: _theme.textTheme.subtitle2,
                      ),
                    ),
                    Container(
                        width: _size.width * .7,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) =>
                              _emailController.text = newValue,
                          validator: (data) {
                            String error =
                                _validator.validateEmail(context, data);
                            return error;
                          },
                          style: _theme.textTheme.bodyText1
                              .copyWith(color: KDarkGreyColor),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText:
                                  _translator.translate("enter_your_email"),
                              hintStyle: _theme.textTheme.caption
                                  .copyWith(color: KDarkGreyColor),
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, right: 8, left: 8),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        )),

                    Padding(
                      padding: EdgeInsets.only(top: KdefaultPadding),
                      child: Container(
                        width: 170,
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Navigator.pushNamed(
                                    context, EmailConfirmCode.routeName,
                                    arguments: _emailController.text);
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
                    Padding(
                      padding: EdgeInsets.only(top: KdefaultPadding),
                      child: Container(
                        width: 170,
                        child: RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              _translator.translate("cancel"),
                              style: _theme.textTheme.button,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
