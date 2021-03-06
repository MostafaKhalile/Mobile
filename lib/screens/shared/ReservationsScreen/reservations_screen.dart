import 'package:flutter/material.dart';

import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Screens/shared/ReservationsScreen/previous_reservations.dart';

import 'upcoming_reservations.dart';

class ReservationsScreen extends StatefulWidget {
  static const String routeName = "/schedule_screen";
  @override
  ReservationsScreenState createState() => ReservationsScreenState();
}

class ReservationsScreenState extends State<ReservationsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Material(
            elevation: 5,
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultRadius)),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: Colors.grey[400],
                  ),
                  hintStyle: _theme.textTheme.caption,
                  hintText: _translator.translate("search_for_order_code")),
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _controller,
          indicatorColor: AppColors.primaryColor,
          tabs: [
            Tab(
              text: _translator.translate("next_appointments"),
            ),
            Tab(
              text: _translator.translate("previous_appointments"),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: TabBarView(
          controller: _controller,
          children: <Widget>[UpcomingReservations(), PreviousReservations()],
        ),
      ),
    );
  }
}
