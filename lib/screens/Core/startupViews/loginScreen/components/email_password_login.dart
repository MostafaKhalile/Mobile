import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/validation.dart';
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
                      onPressed: () => {
                        if (_formKey.currentState.validate())
                          {_formKey.currentState.save()}
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('login'),
                        style: Theme.of(context).textTheme.button,
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
