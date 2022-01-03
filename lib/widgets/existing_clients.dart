import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/models/existing_clients_piechart.dart';
import 'package:insurance_portal/models/existing_clients_info_card.dart';

class ExistingClients extends StatelessWidget {
  const ExistingClients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Chart(),
          StorageInfoCard(
            icon: FontAwesome5.car_crash,
            title: "Vehicle insurance",
            amountOfFiles: "100",
            numOfFiles: 78,
          ),
          StorageInfoCard(
            icon: FontAwesome5.heartbeat,
            title: "Life insurance",
            amountOfFiles: "43",
            numOfFiles: 43,
          ),
          StorageInfoCard(
            icon: Icons.sailing,
            title: "Marine Insurance",
            amountOfFiles: "43",
            numOfFiles: 43,
          ),
        ],
      ),
    );
  }
}
