import 'package:flutter/material.dart';

class VehicleInsurer with ChangeNotifier {
  final String insurerId;
  final String insurerName;
  final String comprehensiveRate;
  final String thirdParty;

  VehicleInsurer(
      {required this.insurerId,
        required this.insurerName,
        required this.comprehensiveRate,
        required this.thirdParty,
      });
}
