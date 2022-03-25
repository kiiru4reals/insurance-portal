import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insurance_portal/services/global_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';

class AddVehicleInsurer extends StatefulWidget {
  static const routeName = "/AddVehicleInsurer";

  @override
  _AddVehicleInsurerState createState() => _AddVehicleInsurerState();
}

class _AddVehicleInsurerState extends State<AddVehicleInsurer> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _comprehensiveRateNode = FocusNode();
  final FocusNode _thirdPartyNode = FocusNode();
  final FocusNode _pickedImageNode = FocusNode();
  String _insurerName = "";
  var _comprehensiveRate = "";
  var _thirdParty = "";
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  String? url;
  var uuid = Uuid();
  late bool kisweb;

  void dispose() {
    _comprehensiveRateNode.dispose();
    _thirdPartyNode.dispose();
    _pickedImageNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_insurerName == null) {
          _globalMethods.authErrorHandle('Please pick insurer name', context);
        } else {
          setState(() {
            _isLoading = true;
          });

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final insurerId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('vehicleInsurers')
              .doc(insurerId)
              .set({
            'insurerId': insurerId,
            'insurerName': _insurerName,
            'comprehensiveRate': _comprehensiveRate,
            'thirdParty': _thirdParty,
            'userId': _uid,
            'createdAt': Timestamp.now(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConsts.bgColor,
        centerTitle: true,
        title: Text("Add new vehicle insurer"),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name cannot be null';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_comprehensiveRateNode),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        prefixIcon: Icon(Icons.label_outlined),
                        labelText: 'Insurer name',
                      ),
                      onSaved: (value) {
                        _insurerName = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('Comprehensive rate'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter comprehensive rate';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_thirdPartyNode),
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.percent_outlined),
                          labelText: 'Comprehensive rate',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _comprehensiveRate = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('Third party price'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Third party price';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_pickedImageNode),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.attach_money_outlined),
                          labelText: 'Third party price',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _thirdParty = value!;
                      },
                    ),
                  ),
                  // SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*Text("Forgot password?", style: TextStyle(
                            color: Colors.orangeAccent[700],
                          ),),*/
                      ],
                    ),
                  ),
                  // SizedBox(height: 20,),
                  _isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: _submitForm,
                          child: Container(
                            alignment: Alignment.center,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    ColorConsts.gradientButtonLeft,
                                    ColorConsts.gradientButtonRight
                                  ]),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
