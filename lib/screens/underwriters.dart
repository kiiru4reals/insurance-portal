import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/routes/add_underwriters/vehicle_underwriters.dart';
class UnderWriters extends StatefulWidget {
  const UnderWriters({Key? key}) : super(key: key);

  @override
  _UnderWritersState createState() => _UnderWritersState();
}

class _UnderWritersState extends State<UnderWriters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConsts.bgColor,
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
              onTap: () => Navigator.of(context).pushNamed(VehicleUnderwriters.routeName),
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
              onTap: () => Navigator.of(context).pushNamed(VehicleUnderwriters.routeName),
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
