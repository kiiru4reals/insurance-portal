import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/vehicles_provider.dart';
import 'package:insurance_portal/widgets/no_clients.dart';
import 'package:insurance_portal/widgets/show_vehicles.dart';
import 'package:provider/provider.dart';

class VehicleClients extends StatefulWidget {
  static const routeName = "/VehicleClients";
  @override
  _VehicleClientsState createState() => _VehicleClientsState();
}

class _VehicleClientsState extends State<VehicleClients> {
  @override
  Widget build(BuildContext context) {
    final vcAttributes = Provider.of<InsuredVehiclesProvider>(context);
    vcAttributes.fetchCars();
    return vcAttributes.getCars.isEmpty
        ? Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConsts.bgColor,
        title: Text("No vehicle insurance clients"),
      ),
      body: NoClients(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
            'Total clients: (${vcAttributes.getCars
                .length})'),
      ),
      body: ListView.builder(
          itemCount: vcAttributes.getCars.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
              value: vcAttributes.getCars[index],
              child: ShowVehicles(
                vehicleId:
                vcAttributes.getCars.toString()[index],
              ),
            );
          }),
    );
  }
}