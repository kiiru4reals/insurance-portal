import 'package:flutter/material.dart';

class Life with ChangeNotifier {
  final String lifeInsuranceId;
  final String packageName;
  final String userId;
  final String firstName;
  final String lastName;

  Life(
      {required this.packageName,
      required this.lifeInsuranceId,
      required this.userId,
      required this.firstName,
      required this.lastName});
}
