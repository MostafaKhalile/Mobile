import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';

class SmsVerification extends StatefulWidget {
  @override
  _SmsVerificationState createState() => _SmsVerificationState();
}

class _SmsVerificationState extends State<SmsVerification> {
  bool _onEditing = true;
  String _code;
  Snackbar _snackBar = Snackbar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'SMS verify code',
            style: TextStyle(color: Colors.black),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Enter your code',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Builder(
              builder: (context) => VerificationCode(
                    textStyle: TextStyle(
                        fontSize: 20.0, color: Theme.of(context).primaryColor),
                    keyboardType: TextInputType.number,
                    underlineColor: Theme.of(context).primaryColor,
                    length: 4,
                    clearAll: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'clear all',
                        style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    onCompleted: (String value) {
                      setState(() {
                        _code = value;
                      });
                      if (value == "1111") {
                        Navigator.pushReplacementNamed(context, "/clientHome");
                      } else {
                        _snackBar.showSnackBar(
                          context,
                          AppLocalizations.of(context).translate("codeError"),
                        );
                      }
                    },
                    onEditing: (bool value) {
                      setState(() {
                        _onEditing = value;
                      });
                      if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                  )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: _onEditing
                  ? Text('Please enter full code')
                  : Text('Your code: $_code'),
            ),
          )
        ],
      ),
    );
  }
}
