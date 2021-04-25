import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

import 'components/cover_and_image.dart';
import 'components/profile_text_field.dart';

class ProfileEdit extends StatefulWidget {
  static const String routeName = "/profile_edit";
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Decoration _imagePikerDecoration = BoxDecoration(
      image: DecorationImage(
        image: 1 < 0
            ? NetworkImage(
                KPlaceHolder,
              )
            : AssetImage(KPlaceHolderImage),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(KdefaultRadius),
      ));
  TextEditingController _firstNameController =
      TextEditingController(text: "firstName");
  TextEditingController _lastNameController =
      TextEditingController(text: "lasttName");
  TextEditingController _emailController = TextEditingController(text: "email");
  TextEditingController _mobileController =
      TextEditingController(text: "lasttName");
  TextEditingController _passwordController =
      TextEditingController(text: "Password");

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: ProfileCoverAndImage(
                    imagePikerDecoration: _imagePikerDecoration)),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(top: _size.height * 0.18),
                child: Column(
                  children: [
                    ProfileTextField(
                        controller: _firstNameController, theme: _theme),
                    ProfileTextField(
                        controller: _lastNameController, theme: _theme),
                    ProfileTextField(
                        controller: _emailController, theme: _theme),
                    ProfileTextField(
                        controller: _mobileController, theme: _theme),
                    ProfileTextField(
                        enabled: false,
                        controller: _passwordController,
                        theme: _theme),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
