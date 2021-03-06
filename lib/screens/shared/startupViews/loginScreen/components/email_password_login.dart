import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/blocs/core/Auth/authantication_bloc.dart';
import 'package:techtime/Controllers/providers/current_user_provider.dart';

import 'package:techtime/Controllers/Repositories/Auth/repository.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';
import 'package:techtime/Helpers/utils/keyboard_unit.dart';
import 'package:techtime/Helpers/validation.dart';
import 'package:techtime/Screens/company/company_main_screen.dart';
import 'package:techtime/screens/Client/home_page.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class EmailPasswordLoginForm extends StatefulWidget {
  const EmailPasswordLoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _EmailPasswordLoginFormState createState() => _EmailPasswordLoginFormState();
}

class _EmailPasswordLoginFormState extends State<EmailPasswordLoginForm> {
  final Validator _validator = Validator();
  final Snackbar _snackbar = Snackbar();
  UserRole? _userRole;
  final AuthRepo _authRepo = AuthRepo();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _token;
  late Stream<String> _tokenStream;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void setToken(String? token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BFmXjDka5aR-tYzYfHufiqcFJi1G5wx-woYAwcoa00bJEVajUCO57W4qlFWMc1Ik2A7etSjgVROmGvACGeBJNS8')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthanticationBloc, AuthanticationState>(
        listener: (context, state) {
      if (state is LoginFailed) {
        KeyboardUtil.hideKeyboard(context);
        _snackbar.showSnackBar(context, state.message);
      } else if (state is LoginSuccesseded) {
        _userRole = _authRepo.userType;
        Provider.of<CurrentUserProvider>(context, listen: false)
            .loadCurrentUser();
        if (_userRole == UserRole.client) {
          Navigator.pushNamedAndRemoveUntil(
              context, ClientHomePage.routeName, (route) => false);
        }
        if (_userRole == UserRole.company) {
          Navigator.pushNamedAndRemoveUntil(
              context, CompanyMainScreen.routeName, (route) => false);
        }
      }
    }, builder: (context, state) {
      return Expanded(
        flex: 2,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => _emailController.text = newValue!,
                validator: (data) {
                  final String? error =
                      _validator.validateEmailMobile(context, data);
                  return error;
                },
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black),
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.translate('mobile/email'),
                    labelStyle: const TextStyle(color: Colors.black)),
              ),
              const VerticalGap(),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => _passwordController.text = newValue!,
                validator: (data) {
                  final String? error =
                      _validator.validatePassword(context, data);
                  return error;
                },
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.translate('password'),
                  labelStyle: const TextStyle(color: Colors.black),
                  suffixIcon: IconButton(
                    onPressed: () => _toggle(),
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const VerticalGap(),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  // ignore: deprecated_member_use
                  child: BlocBuilder<AuthanticationBloc, AuthanticationState>(
                    builder: (context, state) {
                      // ignore: deprecated_member_use
                      return RaisedButton(
                        onPressed: state is LoginInProgress
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  BlocProvider.of<AuthanticationBloc>(context)
                                      .add(StartLogin(_emailController.text,
                                          _passwordController.text, _token!));
                                }
                              },
                        disabledColor: AppColors.darkGreyColor,
                        child: BlocBuilder<AuthanticationBloc,
                            AuthanticationState>(
                          builder: (context, state) {
                            if (state is LoginInProgress) {
                              return const SizedBox(
                                height: 10,
                                width: 10,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Text(
                              AppLocalizations.of(context)!.translate('login')!,
                              style: Theme.of(context).textTheme.button,
                            );
                          },
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      );
    });
  }
}
