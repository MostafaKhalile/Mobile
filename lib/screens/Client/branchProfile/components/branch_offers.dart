import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class BranchOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(height: 100, child: Text("Item 1")),
            Container(height: 100, child: Text("Item 2")),
            Container(height: 100, child: Text("Item 3")),
            Container(height: 100, child: Text("Item 4")),
            Container(height: 100, child: Text("Item 5")),
            Container(height: 100, child: Text("Item 6")),
            Container(height: 100, child: Text("Item 7")),
            Container(height: 100, child: Text("Item 8")),
            Container(height: 100, child: Text("Item 9")),
            Container(height: 100, child: Text("Item 10")),
          ],
        ),
      ),
    );
  }
}
