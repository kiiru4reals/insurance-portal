import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';

class FlipVehicleClient extends StatefulWidget {
  static const routeName = "/FlipVehicleClient";

  @override
  _FlipVehicleClientState createState() => _FlipVehicleClientState();
}

class _FlipVehicleClientState extends State<FlipVehicleClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Vehicle insurance client"),
        backgroundColor: ColorConsts.bgColor,
      ),
      body: Center(
        child: Container(
          child: Text("To be Continued"),
        ),

      ),
    );
  }
}
