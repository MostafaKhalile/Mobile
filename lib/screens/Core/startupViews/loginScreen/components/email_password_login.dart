import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/blocs/core/Auth/authantication_bloc.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';
import 'package:techtime/Helpers/utils/keyboard_unit.dart';
import 'package:techtime/Helpers/validation.dart';
import 'package:techtime/screens/Client/home_page.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class EmailPasswordLoginForm extends StatefulWidget {
  const EmailPasswordLoginForm({
    Key key,
  }) : super(key: key);

  @override
  _EmailPasswordLoginFormState createState() => _EmailPasswordLoginFormState();
}

class _EmailPasswordLoginFormState extends State<EmailPasswordLoginForm> {
  Validator _validator = Validator();
  Snackbar _snackbar = Snackbar();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthanticationBloc, AuthanticationState>(
        listener: (context, state) {
      if (state is LoginFailed) {
        KeyboardUtil.hideKeyboard(context);
        _snackbar.showSnackBar(context, state.message);
      } else if (state is LoginSuccesseded) {
        Navigator.pushNamedAndRemoveUntil(
            context, ClientHomePage.routeName, (route) => false);
      }
    }, builder: (context, state) {
      return Expanded(
        flex: 2,
        child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => _emailController.text = newValue,
                    validator: (data) {
                      String error =
                          _validator.validateEmailMobile(context, data);
                      return error;
                    },
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.black),
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('mobile/email'),
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  VerticalGap(),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => _passwordController.text = newValue,
                    validator: (data) {
                      String error = _validator.validatePassword(context, data);
                      return error;
                    },
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.black),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('password'),
                      labelStyle: TextStyle(color: Colors.black),
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
                  VerticalGap(),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            BlocProvider.of<AuthanticationBloc>(context).add(
                                StartLogin(_emailController.text,
                                    _passwordController.text));
                          }
                        },
                        child: BlocBuilder<AuthanticationBloc,
                            AuthanticationState>(
                          builder: (context, state) {
                            if (state is LoginInProgress) {
                              return SizedBox(
                                height: 10,
                                width: 10,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Text(
                              AppLocalizations.of(context).translate('login'),
                              style: Theme.of(context).textTheme.button,
                            );
                          },
                        ),
                      )),
                ],
              ),
            )),
      );
    });
  }
}
