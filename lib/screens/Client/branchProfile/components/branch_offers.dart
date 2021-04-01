import 'package:flutter/material.dart';

class BranchOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: <Widget>[
                    Text('One'),
                    Text('Two'),
                    Text('Three'),
                    Text('Four'),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: <Widget>[
                    Text('One'),
                    Text('Two'),
                    Text('Three'),
                    Text('Four'),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: <Widget>[
                    Text('One'),
                    Text('Two'),
                    Text('Three'),
                    Text('Four'),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: <Widget>[
                    Text('One'),
                    Text('Two'),
                    Text('Three'),
                    Text('Four'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
