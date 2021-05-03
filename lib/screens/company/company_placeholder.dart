import 'package:flutter/material.dart';
import 'package:techtime/Controllers/repositories/Auth/repository.dart';
import 'package:techtime/screens/Core/startupViews/language_selection_page.dart';

class CompanyPlaceholder extends StatelessWidget {
  static const String routeName = "/company_app";
  bool isLogedOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Company App is Under Development Right Now"),
            TextButton(
                onPressed: () async {
                  isLogedOut = await AuthRepo().logout();
                  if (isLogedOut) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        LanguageSelectionPage.routeName, (route) => false);
                  }
                },
                child: Text(
                  "Log Out",
                  style: Theme.of(context).textTheme.button,
                ))
          ],
        ),
      ),
    );
  }
}
