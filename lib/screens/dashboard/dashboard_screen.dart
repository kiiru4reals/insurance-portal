import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/responsive.dart';
import 'package:insurance_portal/widgets/header.dart';
import 'package:insurance_portal/widgets/existing_clients.dart';
import 'package:insurance_portal/widgets/prospective_clients_card.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      ProspectiveClients(),
                      SizedBox(height: defaultPadding),
                      // RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) ExistingClients(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: ExistingClients(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}