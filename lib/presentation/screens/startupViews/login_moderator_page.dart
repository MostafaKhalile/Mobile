import 'package:flutter/material.dart';
import 'package:techtime/constants/app_consts.dart';
import 'package:techtime/data/models/AppConfgModels/app_localizations_delegates.dart';

class LoginModeratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 25,
                right: 10,
                child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/clientHome'),
                    child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('skip'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                            )
                          ],
                        )))),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/logo.png"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(KAppName,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/login'),
                              child: Text(
                                AppLocalizations.of(context).translate('login'),
                                style: Theme.of(context).textTheme.button,
                              ),
                            )),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, "/clientRegistration"),
                            child: Text(
                              AppLocalizations.of(context).translate('signup'),
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('companyRegister'),
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
