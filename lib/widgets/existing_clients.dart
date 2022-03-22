import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/models/existing_clients_piechart.dart';
import 'package:insurance_portal/models/existing_clients_info_card.dart';
import 'package:insurance_portal/providers/life_provider.dart';
import 'package:insurance_portal/providers/vehicles_provider.dart';
import 'package:provider/provider.dart';

class ExistingClients extends StatelessWidget {
  const ExistingClients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vcAttributes = Provider.of<InsuredVehiclesProvider>(context);
    vcAttributes.fetchCars();
    final lcAttributes = Provider.of<InsuredLivesProvider>(context);
    lcAttributes.fetchLifeInsured();
    int totallifeclients = lcAttributes.getLives.length.toInt();
    int totalvehicles = vcAttributes.getCars.length.toInt();
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Clients",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          // Chart(),
          StorageInfoCard(
            icon: FontAwesome5.car_crash,
            title: "Vehicle insurance",
            amountOfFiles: "$totalvehicles",
            numOfFiles: 78,
          ),
          StorageInfoCard(
            icon: FontAwesome5.heartbeat,
            title: "Life insurance",
            amountOfFiles: "$totallifeclients",
            numOfFiles: 43,
          ),
          StorageInfoCard(
            icon: Icons.sailing,
            title: "Marine Insurance",
            amountOfFiles: "$totalvehicles",
            numOfFiles: 43,
          ),
        ],
      ),
    );
  }
}
