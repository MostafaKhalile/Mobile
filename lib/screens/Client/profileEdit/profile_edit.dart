import 'package:flutter/material.dart';

import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/models/client_profile.dart';
import 'package:techtime/models/user.dart';
import 'components/cover_and_image.dart';
import 'components/profile_text_field.dart';

class ProfileEdit extends StatefulWidget {
  static const String routeName = "/profile_edit";

  const ProfileEdit({Key key, @required this.profileDatat}) : super(key: key);
  @override
  _ProfileEditState createState() => _ProfileEditState();
  final ClientProfile profileDatat;
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _firstNameController;

  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _mobileController;
  TextEditingController _passwordController =
      TextEditingController(text: "Password");
  User _currentUser;
  @override
  void initState() {
    _firstNameController = TextEditingController(
        text: widget.profileDatat.firstName ?? "FirstName");
    _lastNameController =
        TextEditingController(text: widget.profileDatat.lastName ?? "LastName");
    _emailController =
        TextEditingController(text: widget.profileDatat.email ?? "email");
    _mobileController = TextEditingController(
        text: widget.profileDatat.mobile.toString() ?? "mobile");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    // AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: ProfileCoverAndImage(
                    currentUser: _currentUser,
                    imagePikerDecoration: BoxDecoration(
                        image: DecorationImage(
                          image: _currentUser?.image != null
                              ? NetworkImage(
                                  KAPIURL + _currentUser.image,
                                )
                              : AssetImage(KPlaceHolderImage),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(KdefaultRadius),
                        )))),
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
