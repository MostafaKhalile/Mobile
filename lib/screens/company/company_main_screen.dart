import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:techtime/Controllers/providers/menu_controller.dart';
import 'package:techtime/Helpers/utils/responsive.dart';
import 'package:techtime/Screens/company/side_menu.dart';
import 'package:provider/provider.dart';

class CompanyMainScreen extends StatelessWidget {
  static const String routeName = "/company_main_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      appBar: Responsive.isMobile(context)
          ? AppBar()
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
