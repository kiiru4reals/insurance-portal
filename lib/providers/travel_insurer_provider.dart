import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/models/travel_insurers_attr.dart';

class TravelInsurersProvider with ChangeNotifier {
  List<TravelInsurer> _travelinsurer = [];

  List<TravelInsurer> get gettravelinsurer {
    return [..._travelinsurer];
  }

  Future<void> fetchTravelInsurer() async {
    // print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('travelInsurers')
        .get()
        .then((QuerySnapshot travelInsurerSnapshot) {
      _travelinsurer = [];
      travelInsurerSnapshot.docs.forEach((element) {
        _travelinsurer.insert(
          0,
          TravelInsurer(
            travelinsurerId: element.get('travelinsurerId'),
            accidentalDeath: element.get('accidentalDeath'),
            covidInclusion: element.get('covidInclusion'),
            emergencyHospitalisation: element.get('emergencyHospitalisation'),
            hijackHostage: element.get('hijackHostage'),
            hospitalCashBenefit: element.get('hospitalCashBenefits'),
            journeyCancellation: element.get('journeyCancellation'),
            journeyCurtailment: element.get('journeyCurtailment'),
            legalExpenses: element.get('legalExpenses'),
            lostCash: element.get('lostCash'),
            luggage: element.get('lostLuggage'),
            luggageDelay: element.get('luggageDelay'),
            packageName: element.get('packageName'),
            packagePrice: int.parse(element.get('packagePrice')),
            permanentDisability: element.get('personalDisability'),
            personalLiability: element.get('personalLiability'),
            preexistingConditions: element.get('preExsistingConditions'),
            singleItemLimit: element.get('singleItemLimit'),
            travelDelay: element.get('travelDelay'),
          ),
        );
      });
    });
  }

  List<TravelInsurer> get insurer {
    return _travelinsurer;
  }
}
