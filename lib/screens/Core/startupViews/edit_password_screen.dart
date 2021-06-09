import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_passwod_bloc/editpassword_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_passwod_bloc/editpassword_bloc.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/Widgets/core/vertical_gab.dart';

import 'language_selection_page.dart';

class EditPasswordScreen extends StatefulWidget {
  static const String routeName = "/email_confirm_code";

  @override
  _EditPasswordScreen createState() => _EditPasswordScreen();
}

class _EditPasswordScreen extends State<EditPasswordScreen> {
  bool _obscureText = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    CustomToast _customToast = CustomToast();

    ThemeData _theme = Theme.of(context);
    return BlocConsumer<EditpasswordBloc, EditpasswordState>(
        listener: (context, state) {
      if (state is EditpasswordFaild) {
        _customToast.buildErrorMessage(context, state.message);
      }
      if (state is Editpasswordsuccess) {
        _customToast.buildSuccessMessage(context);
        Navigator.pushNamedAndRemoveUntil(
            context, LanguageSelectionPage.routeName, (route) => false);
      }
    }, builder: (context, state) {
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
                              controller: _oldPasswordController,
                              onSaved: (newValue) =>
                                  _oldPasswordController.text = newValue,
                              style: _theme.textTheme.bodyText1
                                  .copyWith(color: KDarkGreyColor),
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText:
                                      _translator.translate("old_password"),
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
                            TextFormField(
                                obscureText: _obscureText,
                                controller: _newPasswordController,
                                onSaved: (newValue) =>
                                    _oldPasswordController.text = newValue,
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
                            TextFormField(
                                obscureText: _obscureText,
                                controller: _repeatPasswordController,
                                onSaved: (newValue) =>
                                    _oldPasswordController.text = newValue,
                                style: _theme.textTheme.bodyText1
                                    .copyWith(color: KDarkGreyColor),
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText:
                                        _translator.translate("Repassword"),
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
                            onPressed: state is EditpasswordLoading
                                ? null
                                : () {
                                    BlocProvider.of<EditpasswordBloc>(context)
                                        .add(EditPassword({
                                      "old_password":
                                          _oldPasswordController.text,
                                      "password1": _newPasswordController.text,
                                      "password2":
                                          _repeatPasswordController.text
                                    }));
                                  },
                            color: KPrimaryColor,
                            child: BlocBuilder<EditpasswordBloc,
                                EditpasswordState>(
                              builder: (context, state) {
                                if (state is EditpasswordLoading) {
                                  return SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return Text(
                                  _translator.translate("confirm"),
                                  style: _theme.textTheme.button.copyWith(
                                      color: _theme.scaffoldBackgroundColor),
                                );
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
