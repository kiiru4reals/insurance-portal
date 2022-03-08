import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/services/global_methods.dart';
import 'package:uuid/uuid.dart';

class AddLifeInsurer extends StatefulWidget {
  static const routeName = "/AddLifeInsurer";

  @override
  _AddLifeInsurerState createState() => _AddLifeInsurerState();
}

class _AddLifeInsurerState extends State<AddLifeInsurer> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _premiumNode = FocusNode();
  final FocusNode _maxBenefitsNode = FocusNode();
  final FocusNode _ageLimitsNode = FocusNode();
  String _packageName = "";
  var _premium;
  var _maxBenefits;
  var _ageLimits;
  var _parentExtension;
  var _medicalExamination = "Not necessary";
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  var uuid = Uuid();


  void dispose() {
    _maxBenefitsNode.dispose();
    _premiumNode.dispose();
    _ageLimitsNode.dispose();

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
          final lifeinsurerId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('Life insurers')
              .doc(lifeinsurerId)
              .set({
            'lifeinsurerId': lifeinsurerId,
            'packageName': _packageName,
            'premium': _premium,
            'maxBenefits': _maxBenefits,
            'ageLimits': _ageLimits,
            'parentInclusion': _parentExtension,
            'medicalExamination': _medicalExamination,
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
        title: Text("Add life insurer"),
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
                      key: ValueKey('Package name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Package has a name!';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_premiumNode),
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
                      key: ValueKey('Premium price pa'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter premium price';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_maxBenefitsNode),
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.payments_outlined),
                          labelText: 'Premium Price',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _premium = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('Maximum benefits'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Maximum benefits';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_maxBenefitsNode),
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.trending_up_outlined),
                          labelText: 'Maximum benefits',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _maxBenefits = value!;
                      },
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.45,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text('6-65 years'),
                                    value: '6-65 years',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('18-65 years'),
                                    value: '18-65 years',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('65+ years'),
                                    value: '65+ years',
                                  ),
                                ],
                                onChanged: (String? value) {
                                  setState(() {
                                    _ageLimits = value!;
                                    //_controller.text= _productCategory;
                                    print(_ageLimits);
                                  });
                                },
                                hint: Text('Age limit'),
                                value: _ageLimits,
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Container(
                            width: MediaQuery.of(context).size.width*.45,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text('Excluded'),
                                      value: 'Excluded',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Included'),
                                      value: 'Included',
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      _parentExtension = value!;
                                      //_controller.text= _productCategory;
                                      print(_parentExtension);
                                    });
                                  },
                                  hint: Text('Parent extension'),
                                  value: _parentExtension,
                                ),
                            ),
                          ),
                        ],
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
                    onTap:  _submitForm,
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
