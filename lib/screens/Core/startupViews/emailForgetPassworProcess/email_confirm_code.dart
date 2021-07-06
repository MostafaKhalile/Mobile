import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/validation.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class EmailConfirmCode extends StatefulWidget {
  static const String routeName = "/email_forget_password";
  final String emailAddress;

  const EmailConfirmCode({Key key, this.emailAddress}) : super(key: key);

  @override
  _EmailConfirmCodeState createState() => _EmailConfirmCodeState();
}

class _EmailConfirmCodeState extends State<EmailConfirmCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _confirmationCodeController = TextEditingController();
  final Validator _validator = Validator();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context);

    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
                        padding: const EdgeInsets.only(top: defaultPadding * 2),
                        child: Text(
                          _translator.translate("confirm"),
                          style: _theme.textTheme.headline5
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    const VerticalGap(),
                    SvgPicture.asset(emailIcon),
                    // VerticalGap(),
                    Text(
                      _translator
                          .translate("We_will_send_verification_code_to"),
                      style: _theme.textTheme.subtitle2,
                    ),

                    Padding(
                        padding: const EdgeInsets.all(defaultPadding / 2),
                        child: Text(
                          widget.emailAddress,
                          style: _theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        width: _size.width * .7,
                        child: TextFormField(
                          controller: _confirmationCodeController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) =>
                              _confirmationCodeController.text = newValue,
                          validator: (data) {
                            final String error =
                                _validator.validateEmail(context, data);
                            return error;
                          },
                          style: _theme.textTheme.bodyText1
                              .copyWith(color: AppColors.darkGreyColor),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: _translator.translate("Enter_the_code"),
                              hintStyle: _theme.textTheme.caption
                                  .copyWith(color: AppColors.darkGreyColor),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 5, right: 8, left: 8),
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
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                            },
                            color: AppColors.primaryColor,
                            child: Text(
                              _translator.translate("confirm"),
                              style: _theme.textTheme.button.copyWith(
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
