import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_portal/models/life_models.dart';

class InsuredLivesProvider with ChangeNotifier {
  List<Life> _mylife = [];

  List<Life> get getLives {
    return [..._mylife];
  }

  Future<void> fetchLives() async {
    // print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('InsuredLives')
        .get()
        .then((QuerySnapshot InsuredLivesSnapshot) {
      _mylife = [];
      InsuredLivesSnapshot.docs.forEach((element) {
        _mylife.insert(
          0,
          Life(
            lifeInsuranceId: element.get('lifeinsuranceId'),
            packageName: element.get('packageName'),
            firstName: element.get('firstName'),
            lastName: element.get('lastName'),
            userId: element.get('userId'),
            ),
        );
      });
    });
  }
  Life findById(String lifeId) {
    return _mylife.firstWhere((element) => element.lifeInsuranceId == lifeId);
  }

}
