import 'package:flutter/cupertino.dart';

class Car with ChangeNotifier {
  final String vehicleId;
  final String car_registration;
  final double premium;
  // final DateTime valid_date;
  final String insurer;
  final String paymentStatus;

  Car(
      {required this.vehicleId,
        required this.car_registration,
        required this.premium,
        required this.insurer,
        //required this.valid_date,
        required this.paymentStatus});
}