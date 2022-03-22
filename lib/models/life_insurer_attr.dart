import 'package:flutter/material.dart';

class LifeInsurer with ChangeNotifier {
  final String lifeinsurerId;
  final String packageName;
  final int premium;
  final int maximumBenefits;
  final String ageLimits;
  final String parentInclusion;
  final String medicalExamination;

  LifeInsurer({
      required this.lifeinsurerId,
      required this.packageName,
      required this.premium,
      required this.maximumBenefits,
      required this.ageLimits,
      required this.parentInclusion,
      required this.medicalExamination});
}
