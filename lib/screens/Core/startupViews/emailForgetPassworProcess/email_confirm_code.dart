import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _confirmationCodeController = TextEditingController();
  final Validator _validator = Validator();

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
                          _translator.translate("confirm"),
                          style: _theme.textTheme.headline5
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    VerticalGap(),
                    SvgPicture.asset(KEmailIcon),
                    // VerticalGap(),
                    Text(
                      _translator
                          .translate("We_will_send_verification_code_to"),
                      style: _theme.textTheme.subtitle2,
                    ),

                    Padding(
                        padding: EdgeInsets.all(KdefaultPadding / 2),
                        child: Text(
                          widget.emailAddress,
                          style: _theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    Container(
                        width: _size.width * .7,
                        child: TextFormField(
                          controller: _confirmationCodeController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) =>
                              _confirmationCodeController.text = newValue,
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
                              hintText: _translator.translate("Enter_the_code"),
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
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print(_formKey.currentState.toString());
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
