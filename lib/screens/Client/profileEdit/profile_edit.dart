import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/blocs/client/profileBloc/profile_bloc.dart';

import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'components/cover_and_image.dart';
import 'components/profile_text_field.dart';

class ProfileEdit extends StatefulWidget {
  static const String routeName = "/profile_edit";

  const ProfileEdit({Key key}) : super(key: key);
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _firstNameController;

  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _mobileController;
  TextEditingController _passwordController =
      TextEditingController(text: "Password");
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(FetchProfileData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;
    // AppLocalizations _translator = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileDataLoaded) {
            _firstNameController = TextEditingController(
                text: state.profile.firstName ?? "FirstName");
            _lastNameController = TextEditingController(
                text: state.profile.lastName ?? "LastName");
            _emailController =
                TextEditingController(text: state.profile.email ?? "email");
            _mobileController = TextEditingController(
                text: state.profile.mobile.toString() ?? "mobile");
          }
        },
        builder: (context, state) {
          if (state is ProfileDataLoaded) {
            return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: ProfileCoverAndImage(
                            userData: state.profile,
                            imagePikerDecoration: BoxDecoration(
                                image: DecorationImage(
                                  image: state.profile?.image != null
                                      ? NetworkImage(
                                          KAPIURL + state.profile?.image,
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
                                controller: _firstNameController,
                                theme: _theme),
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
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
