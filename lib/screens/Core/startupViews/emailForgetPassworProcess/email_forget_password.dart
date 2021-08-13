import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
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
  final Validator _validator = Validator();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context)!;

    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _translator.translate("forgotPassword")!,
          style: Theme.of(context)
              .textTheme
              .headline6!
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
                        padding: const EdgeInsets.only(top: defaultPadding * 2),
                        child: Text(
                          _translator.translate("forgotPassword")!,
                          style: _theme.textTheme.headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    const VerticalGap(),
                    SvgPicture.asset(contactUsIcon),
                    // VerticalGap(),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        _translator.translate("enter_your_email")!,
                        style: _theme.textTheme.subtitle2,
                      ),
                    ),
                    SizedBox(
                        width: _size.width * .7,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) =>
                              _emailController.text = newValue!,
                          validator: (data) {
                            final String? error =
                                _validator.validateEmail(context, data);
                            return error;
                          },
                          style: _theme.textTheme.bodyText1!
                              .copyWith(color: AppColors.darkGreyColor),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText:
                                  _translator.translate("enter_your_email"),
                              hintStyle: _theme.textTheme.caption!
                                  .copyWith(color: AppColors.darkGreyColor),
                              contentPadding: const EdgeInsets.only(
                                  bottom: 5, right: 8, left: 8),
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        )),

                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: SizedBox(
                        width: 170,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.pushNamed(
                                    context, EmailConfirmCode.routeName,
                                    arguments: _emailController.text);
                              }
                            },
                            color: AppColors.primaryColor,
                            child: Text(
                              _translator.translate("confirm")!,
                              style: _theme.textTheme.button!.copyWith(
                                  color: _theme.scaffoldBackgroundColor),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: SizedBox(
                        width: 170,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              _translator.translate("cancel")!,
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
