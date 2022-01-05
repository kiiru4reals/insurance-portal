import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/screens/main_screen.dart';
import 'package:insurance_portal/services/global_methods.dart';
import 'package:insurance_portal/side_menu.dart';

class NewAdminUser extends StatefulWidget {
  const NewAdminUser({Key? key}) : super(key: key);

  @override
  _NewAdminUserState createState() => _NewAdminUserState();
}

class _NewAdminUserState extends State<NewAdminUser> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  String _pickedImage = 'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg';
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConsts.bgColor,
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ColorConsts.hbSkyblue, ColorConsts.hbWhite])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
/*              SizedBox(
                height: 20,
              ),*/
              // Image.asset('assets/images/logo.png'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Create new user',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Container(
                  // height: 300,
                  width: 480,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        "Enter relevant user information",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          key: ValueKey('name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name cannot be empty';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: Text('Full Name'),
                            prefixIcon: Icon(
                              Icons.person,
                              size: 17,
                            ),
                          ),
                          onSaved: (value) {
                            _fullName = value!;
                          },
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          key: ValueKey('email'),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: Text('Email Address'),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 17,
                            ),
                          ),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          key: ValueKey('Password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid Password';
                            }
                            return null;
                          },
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            label: Text('Password'),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              size: 17,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: _obscureText,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          key: ValueKey('phone'),
                          focusNode: _phoneNumberFocusNode,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Please enter a real phone number';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _submitForm,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            label: Text('Phone Number'),
                            prefixIcon: Icon(
                              Icons.phone_android,
                              size: 17,
                            ),
                          ),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value!);
                          },
                        ),
                      ),
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
/*                      _isLoading ? CircularProgressIndicator() :*/ GestureDetector(
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
                              "Create User",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}