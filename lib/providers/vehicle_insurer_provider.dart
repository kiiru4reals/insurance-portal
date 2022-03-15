import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/models/vehicle_insurer_attr.dart';

class VehicleInsurersProvider with ChangeNotifier {
  List<VehicleInsurer> _vehicleinsurer= [];
  List <VehicleInsurer> get getvehicleinsurer {
    return [..._vehicleinsurer];
  }
  Future<void> fetchInsurer() async {
    // print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('vehicleInsurers')
        .get()
        .then((QuerySnapshot vehicleInsurerSnapshot) {
      _vehicleinsurer = [];
      vehicleInsurerSnapshot.docs.forEach((element) {
        _vehicleinsurer.insert(
          0,
            VehicleInsurer(
                insurerId: element.get('insurerId'),
                insurerName: element.get('insurerName'),
                comprehensiveRate: element.get('comprehensiveRate'),
                thirdParty: element.get('thirdParty'),
            ),
        );
      });
    });
  }
  List<VehicleInsurer> get insurer {
    return _vehicleinsurer;
  }
}