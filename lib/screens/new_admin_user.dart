import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/services/global_methods.dart';
import 'package:insurance_portal/widgets/side_menu.dart';

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
  String _phoneNumber = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_password == null) {
          _globalMethods.authErrorHandle('Enter password', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim());
          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          user.updateProfile(displayName: _fullName);
          user.reload();
          await FirebaseFirestore.instance.collection('admins').doc(_uid).set({
            'id': _uid,
            'name': _fullName,
            'email': _emailAddress,
            'phoneNumber': _phoneNumber,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now(),
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        // _globalMethods.authErrorHandle(error.message, context);
        print('error occured ${error}');
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
      ),
      drawer: SideMenu(),
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
                          .requestFocus(_emailFocusNode),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        prefixIcon: Icon(Icons.drive_file_rename_outline_sharp),
                        labelText: 'Full name',
                      ),
                      onSaved: (value) {
                        _fullName = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('Email address'),
                      focusNode: _emailFocusNode,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Enter valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passwordFocusNode),
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email address',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _emailAddress = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('Password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter a valid Password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _passwordFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_phoneNumberFocusNode),
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.lock),
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
                          labelText: 'Password',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _password = value!;
                      },
                      obscureText: _obscureText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey('Phone number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter phone number';
                        }
                        return null;
                      },
                      focusNode: _phoneNumberFocusNode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.smartphone),
                          labelText: 'Phone number',
                          fillColor: Theme.of(context).backgroundColor),
                      onSaved: (value) {
                        _phoneNumber = value!;
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
