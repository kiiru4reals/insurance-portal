import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/routes/add_underwriters/add_life_insurer.dart';
import 'package:insurance_portal/routes/add_underwriters/add_vehicle_insurer.dart';

class SelectUnderwriter extends StatefulWidget {
  static const routeName = "/SelectUnderwriter";

  @override
  _SelectUnderwriterState createState() => _SelectUnderwriterState();
}

class _SelectUnderwriterState extends State<SelectUnderwriter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConsts.bgColor,
        centerTitle: true,
        title: Text("Select type"),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(AddVehicleInsurer.routeName),
              child: Card(
                color: Colors.transparent,
                shadowColor: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Vehicle Insurance',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const SizedBox(height: 8),
                      /*           Text(
                          'Parent company website.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),*/
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(AddLifeInsurer.routeName),
              child: Card(
                color: Colors.transparent,
                shadowColor: Colors.black,
                // elevation: 0,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Life Insurance',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const SizedBox(height: 8),
                      /*Text(
                        'Business systems to manage your workflows, enhance performance and efficiency.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
