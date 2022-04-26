import 'package:flutter/material.dart';

class TravelInsurer with ChangeNotifier {
  final String travelinsurerId;
  final String packageName;
  final String emergencyHospitalisation;
  final String preexistingConditions;
  final String accidentalDeath;
  final String permanentDisability;
  final String journeyCancellation;
  final String journeyCurtailment;
  final String travelDelay;
  final String personalLiability;
  final String hijackHostage;
  final String legalExpenses;
  final String luggage;
  final String singleItemLimit;
  final String lostCash;
  final String luggageDelay;
  final String hospitalCashBenefit;
  final int packagePrice;
  final String covidInclusion;

  TravelInsurer(
      {required this.travelinsurerId,
      required this.packageName,
      required this.emergencyHospitalisation,
      required this.preexistingConditions,
      required this.accidentalDeath,
      required this.permanentDisability,
      required this.journeyCancellation,
      required this.journeyCurtailment,
      required this.travelDelay,
      required this.personalLiability,
      required this.hijackHostage,
      required this.legalExpenses,
      required this.luggage,
      required this.singleItemLimit,
      required this.lostCash,
      required this.luggageDelay,
      required this.hospitalCashBenefit,
      required this.packagePrice,
      required this.covidInclusion,});
}
