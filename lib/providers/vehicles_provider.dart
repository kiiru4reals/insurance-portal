import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_portal/models/vehicle_models.dart';

class InsuredVehiclesProvider with ChangeNotifier {
  List<Car> _mycars = [];

  List<Car> get getCars {
    return [..._mycars];
  }

  Future<void> fetchCars() async {
    print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('InsuredVehicles')
        .get()
        .then((QuerySnapshot InsuredVehiclesSnapshot) {
      _mycars = [];
      InsuredVehiclesSnapshot.docs.forEach((element) {
        _mycars.insert(
          0,
          Car(
            vehicleId: element.get('vehicleId'),
            car_registration: element.get('registrationNumber'),
            premium: double.parse(
              element.get('vehiclePremium'),
            ),
            insurer: element.get('insurer'),
            // valid_date: DateTime.parse(element.get('requestMade')),
            paymentStatus: element.get('paymentStatus'),
          ),
        );
      });
    });
  }
  Car findById(String vehiclesId) {
    return _mycars.firstWhere((element) => element.vehicleId == vehiclesId);
  }

}
