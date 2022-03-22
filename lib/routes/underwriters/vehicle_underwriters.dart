import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/vehicle_insurer_provider.dart';
import 'package:insurance_portal/widgets/no_underwriters.dart';
import 'package:insurance_portal/widgets/show_vehicle_insurers.dart';
import 'package:provider/provider.dart';

class VehicleUnderwriters extends StatefulWidget {
  static const routeName = "/VehicleUnderwriters";

  @override
  _VehicleUnderwritersState createState() => _VehicleUnderwritersState();
}

class _VehicleUnderwritersState extends State<VehicleUnderwriters> {
  /*Future<void> _getProductsOnRefresh() async {
    await Provider.of<VehicleInsurersProvider>(context, listen: false)
        .fetchInsurer();
    setState(() {});
  }*/

    @override
    Widget build(BuildContext context) {
      final vuAttributes = Provider.of<VehicleInsurersProvider>(context);
      vuAttributes.fetchInsurer();
      return vuAttributes.getvehicleinsurer.isEmpty
          ? Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConsts.bgColor,
          title: Text("No underwriters"),
        ),
        body: NoUnderWriters(),
      )
          : Scaffold(
        appBar: AppBar(
          title: Text(
              'Total vehicle underwriters: (${vuAttributes.getvehicleinsurer
                  .length})'),
        ),
        body: ListView.builder(
            itemCount: vuAttributes.getvehicleinsurer.length,
            itemBuilder: (BuildContext ctx, int index) {
              return ChangeNotifierProvider.value(
                value: vuAttributes.getvehicleinsurer[index],
                child: ShowVehicleInsurers(
                  insurerId:
                  vuAttributes.getvehicleinsurer.toString()[index],
                ),
              );
            }),
      );
    }
  }