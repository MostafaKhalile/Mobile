import 'package:flutter/material.dart';
import 'package:techtime/Screens/Client/favorites/subViews/favorite_companies.dart';

import 'subViews/favorite_branches.dart';

class FavoritesScreen extends StatefulWidget {
  static const String routeName = '/favorites';

  const FavoritesScreen({Key key}) : super(key: key);
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return DefaultTabController(
      length: 2, // This is the number of tabs.
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorites',
            style: _theme.textTheme.headline6.copyWith(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: TabBar(
            labelColor: Colors.black,
            controller: _controller,
            indicatorColor: Colors.black,
            indicatorWeight: 4,
            unselectedLabelStyle: _theme.textTheme.subtitle2
                .copyWith(fontWeight: FontWeight.bold),
            labelStyle: _theme.textTheme.subtitle2
                .copyWith(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(
                text: "Companies",
              ),
              Tab(
                text: "Branches",
              ),
            ],
          ),
        ),
        body: SizedBox(
            width: double.infinity,
            child: TabBarView(
              controller: _controller,
              children: const <Widget>[FavoriteCompanies(), FavoriteBranches()],
            )),
      ),
    );
  }
}
