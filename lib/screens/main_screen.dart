import 'package:flutter/material.dart';
import 'package:insurance_portal/providers/MenuController.dart';
import 'package:insurance_portal/responsive.dart';
import 'package:insurance_portal/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../side_menu.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/MainScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}