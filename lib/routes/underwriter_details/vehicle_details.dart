import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editable/editable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/providers/vehicles_provider.dart';
import 'package:insurance_portal/services/global_methods.dart';
import 'package:provider/provider.dart';

class VehicleDetails extends StatefulWidget {
  static const routeName = "/VehicleDetails";

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  final _formKey = GlobalKey<FormState>();
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {
    // final showEditIcon = index == 0 || index == 1;
    final CarData = Provider.of<InsuredVehiclesProvider>(context);
    final carId = ModalRoute.of(context)!.settings.arguments as String;
    final CarAttr = CarData.findById(carId);
    final premium = CarAttr.premium;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Editable(
        columns: [
          {"title": 'Information', 'widthFactor': .45, "key": "Information"},
          {"title": 'Details', 'widthFactor': .45, "key": "Details"},
        ],
        rows:  [
          {'Information': 'Registration Number', 'Details': '${CarAttr.car_registration}'},
          {'Information': 'Premium', 'Details': '${premium}'},
          {'Information': 'Insurer', 'Details': '${CarAttr.insurer}'},
          {'Information': 'Payment status', 'Details': '${CarAttr.paymentStatus}'},],
        showSaveIcon: true,
        onRowSaved: (value){
          final _premium = premium;
          final _registration = CarAttr.car_registration;
          final _insurer = CarAttr.insurer;
          final _paymentStatus = CarAttr.paymentStatus;
          final _vehicleId = CarAttr.vehicleId;
          _updatedata(context, _premium, _registration, _insurer, _paymentStatus, _vehicleId);
          print ("Saved");
        },
      ),
    );
  }

  _updatedata(context, double _premium, String registration, String _insurer, String _paymentStatus, String _vehicleId) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_premium== 0.00) {
          _globalMethods.authErrorHandle('Premium can\'t be zero', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          await FirebaseFirestore.instance
              .collection('InsuredLives')
              .doc(_vehicleId)
              .update({
            'vehicleId': _vehicleId,
            'vehiclePremium': "$_premium",
            'registrationNumber': "$registration",
            'insurer': "$_insurer",
            'paymentStatus': "$_paymentStatus",
            'userId': _uid,
            // 'requestMade': Timestamp.today().toString(),
            // 'expiryDate':
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        // _globalMethods.authErrorHandle(error.message, context);
        print('An Error Occurred ${error}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
