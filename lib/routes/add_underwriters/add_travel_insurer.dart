import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/services/global_methods.dart';
import 'package:uuid/uuid.dart';

class AddTravelInsurer extends StatefulWidget {
  static const routeName = "/AddTravelInsurer";

  @override
  _AddTravelInsurerState createState() => _AddTravelInsurerState();
}

class _AddTravelInsurerState extends State<AddTravelInsurer> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _packagePriceFocusNode = FocusNode();
  final FocusNode _accidentalDeathFocusNode = FocusNode();
  final FocusNode _covidInclusionFocusNode = FocusNode();
  final FocusNode _emergencyHospitalisationFocusNode = FocusNode();
  final FocusNode _hijackHostageFocusNode = FocusNode();
  final FocusNode _hospitalCashBenefitsFocusNode = FocusNode();
  final FocusNode _journeyCancellationFocusNode = FocusNode();
  final FocusNode _journeyCurtailmentFocusNode = FocusNode();
  final FocusNode _legalExpensesFocusNode = FocusNode();
  final FocusNode _lostCashFocusNode = FocusNode();
  final FocusNode _luggageFocusNode = FocusNode();
  final FocusNode _luggageDelayFocusNode = FocusNode();
  final FocusNode _personalDisabilityFocusNode = FocusNode();
  final FocusNode _personalLiabilityFocusNode = FocusNode();
  final FocusNode _preExsistingConditionsFocusNode = FocusNode();
  final FocusNode _singleItemLimitFocusNode = FocusNode();
  final FocusNode _travelDelayFocusNode = FocusNode();
  bool _isLoading = false;
  GlobalMethods _globalMethods = GlobalMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uuid = Uuid();

  String _packageName = "";
  String _accidentalDeath = "";
  String _covidInclusion = "";
  String _emergencyHospitalisation = "";
  String _hijackHostage = "";
  String _hospitalCashBenefits = "";
  String _journeyCancellation = "";
  String _journeyCurtailment = "";
  String _legalExpenses = "";
  String _lostCash = "";
  String _luggage = "";
  String _luggageDelay = "";
  String _personalDisability = "";
  String _personalLiability = "";
  String _preExsistingConditions = "";
  String _singleItemLimit = "";
  String _travelDelay = "";
  String _packagePrice = "";

  void dispose() {
    _accidentalDeathFocusNode.dispose();
    _covidInclusionFocusNode.dispose();
    _emergencyHospitalisationFocusNode.dispose();
    _hospitalCashBenefitsFocusNode.dispose();
    _hijackHostageFocusNode.dispose();
    _luggageFocusNode.dispose();
    _luggageDelayFocusNode.dispose();
    _lostCashFocusNode.dispose();
    _legalExpensesFocusNode.dispose();
    _packagePriceFocusNode.dispose();
    _preExsistingConditionsFocusNode.dispose();
    _personalLiabilityFocusNode.dispose();
    _personalDisabilityFocusNode.dispose();
    _singleItemLimitFocusNode.dispose();
    _travelDelayFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_packageName == null) {
          _globalMethods.authErrorHandle('Please enter package name', context);
        } else {
          setState(() {
            _isLoading = true;
          });

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final travelinsurerId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('travelInsurers')
              .doc(travelinsurerId)
              .set({
            'travelinsurerId': travelinsurerId,
            'accidentalDeath': _accidentalDeath,
            'covidInclusion': _covidInclusion,
            'emergencyHospitalisation': _emergencyHospitalisation,
            'hijackHostage': _hijackHostage,
            'hospitalCashBenefits': _hospitalCashBenefits,
            'journeyCancellation': _journeyCancellation,
            'journeyCurtailment': _journeyCurtailment,
            'legalExpenses': _legalExpenses,
            'lostCash': _lostCash,
            'lostLuggage': _luggage,
            'luggageDelay': _luggageDelay,
            'personalDisability': _personalDisability,
            'personalLiability': _personalLiability,
            'preExsistingConditions': _preExsistingConditions,
            'singleItemLimit': _singleItemLimit,
            'travelDelay': _travelDelay,
            'packageName': _packageName,
            'packagePrice': _packagePrice,
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
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
                          key: ValueKey('packageName'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter name';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_accidentalDeathFocusNode),
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.label_outlined),
                            labelText: 'Package name',
                          ),
                          onSaved: (value) {
                            _packageName = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Accidental death'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          focusNode: _accidentalDeathFocusNode,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_covidInclusionFocusNode),
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(FontAwesome5.cross),
                              labelText: 'Accidental death',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _accidentalDeath = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Covid inclusion'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _covidInclusionFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_emergencyHospitalisationFocusNode),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.coronavirus_outlined),
                              labelText: 'Covid inclusion',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _covidInclusion = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Emergency hospitalisation'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _emergencyHospitalisationFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_hijackHostageFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.medical_services_outlined),
                              labelText: 'Emergency hospitalisation',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _emergencyHospitalisation = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Hijack and hostage during travel'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _hijackHostageFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_hospitalCashBenefitsFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.construction_outlined),
                              labelText: 'Hijack and hostage during travel',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _hijackHostage = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Hospital cash benefits'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _hospitalCashBenefitsFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_journeyCancellationFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(FontAwesome5.hospital),
                              labelText: 'Hospital cash benefits',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _hospitalCashBenefits = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Journey cancellation'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _journeyCancellationFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_journeyCurtailmentFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.close_outlined),
                              labelText: 'Journey cancellation',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _journeyCancellation = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Journey curtailment'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _journeyCurtailmentFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_legalExpensesFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.block_outlined),
                              labelText: 'Journey curtailment',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _journeyCurtailment = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Journey curtailment'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _legalExpensesFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_lostCashFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(FontAwesome5.gavel),
                              labelText: 'Legal expenses',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _legalExpenses = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Lost money'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _lostCashFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_luggageFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.money_outlined),
                              labelText: 'Legal expenses',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _lostCash = value!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Lost luggage'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _luggageFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_luggageDelayFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.no_luggage_outlined),
                              labelText: 'Lost luggage',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _luggage = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Luggage delay'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _luggageDelayFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_personalDisabilityFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.timer_outlined),
                              labelText: 'Luggage delay',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _luggageDelay = value!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Personal disability'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _personalDisabilityFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_personalLiabilityFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.accessible_outlined),
                              labelText: 'Personal disability cover',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _personalDisability = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Personal liability'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _personalLiabilityFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_preExsistingConditionsFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.report_problem_outlined),
                              labelText: 'Personal liability',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _personalLiability = value!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Pre exsisting conditions'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _preExsistingConditionsFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_singleItemLimitFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.sick_outlined),
                              labelText: 'Pre exsisting conditions',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _preExsistingConditions = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Single item limit'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _singleItemLimitFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_travelDelayFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(FontAwesome5.shopping_bag),
                              labelText: 'Single item limit',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _singleItemLimit = value!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Travel delay'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _travelDelayFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_packagePriceFocusNode),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(FontAwesome5.plane_slash),
                              labelText: 'Travel delay',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _travelDelay = value!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Price'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter details';
                            }
                            return null;
                          },
                          focusNode: _packagePriceFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(FontAwesome5.dollar_sign),
                              labelText: 'Package price',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _packagePrice = value!;
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
        ],
      ),
    );
  }
}
