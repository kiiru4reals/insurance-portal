import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/models/life_insurer_attr.dart';

class LifeInsurersProvider with ChangeNotifier {
  List<LifeInsurer> _lifeinsurer = [];

  List<LifeInsurer> get getlifeinsurer {
    return [..._lifeinsurer];
  }

  Future<void> fetchInsurer() async {
    // print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('lifeInsurers')
        .get()
        .then((QuerySnapshot lifeInsurerSnapshot) {
      _lifeinsurer = [];
      lifeInsurerSnapshot.docs.forEach((element) {
        _lifeinsurer.insert(
          0,
          LifeInsurer(
            lifeinsurerId: element.get('lifeinsurerId'),
            packageName: element.get('packageName'),
            premium: int.parse(
              element.get('premium'),
            ),
            maximumBenefits: int.parse(
              element.get('maximumBenefits'),
            ),
            ageLimits: element.get('ageLimits'),
            parentInclusion: element.get('parentInclusion'),
            medicalExamination: element.get('medicalExamination'),
          ),
        );
      });
    });
  }

  List<LifeInsurer> get insurer {
    return _lifeinsurer;
  }
}
