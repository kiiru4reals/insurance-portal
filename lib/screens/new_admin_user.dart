import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insurance_portal/constants/color.dart';
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
  String _defaultavatar =
      'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg';
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  int? _phoneNumber;
  File? _pickedImage;
  String? url;
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
        if (_pickedImage == null) {
          _globalMethods.authErrorHandle('Please pick an image', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(_fullName + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await ref.getDownloadURL();
          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim());
          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          user.updateProfile(photoURL: url, displayName: _fullName);
          user.reload();
          await FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _fullName,
            'email': _emailAddress,
            'phoneNumber': _phoneNumber,
            'imageUrl': url,
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

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConsts.bgColor,
      ),
      drawer: SideMenu(),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    height: 15,
                  ),
                  SizedBox(
                    height: 10,
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
                          SizedBox(
                            height: 30,
                          ),
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
                          Column(
                            children: [
                              SizedBox(
                                height: 115,
                                width: 115,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: _pickedImage == null
                                          ? null
                                          : FileImage(_pickedImage!),
                                    ),
                                    Positioned(
                                        right: -16,
                                        bottom: 0,
                                        child: SizedBox(
                                            height: 46,
                                            width: 46,
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                side: BorderSide(color: Colors.white),
                                              ),
                                              color: Color(0xFFF5F6F9),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Choose option',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: ColorConsts.gradiendLStart),
                                                        ),
                                                        content: SingleChildScrollView(
                                                          child: ListBody(
                                                            children: [
                                                              InkWell(
                                                                onTap: _pickImageGallery,
                                                                splashColor: Colors.purpleAccent,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child: Icon(
                                                                        Icons.image,
                                                                        color: Colors.purpleAccent,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Gallery',
                                                                      style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight:
                                                                          FontWeight.w500,
                                                                          color:
                                                                          ColorConsts.title),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: _remove,
                                                                splashColor: Colors.purpleAccent,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child: Icon(
                                                                        Icons.remove_circle,
                                                                        color: Colors.red,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Remove',
                                                                      style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight:
                                                                          FontWeight.w500,
                                                                          color: Colors.red),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              // TODO: Icon not centered.
                                              child: Center(child: Icon(Icons.camera_alt_outlined)),
                                            )))
                                  ],
                                ),
                              ),
                            ],
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
                              onEditingComplete: () =>
                                  FocusScope.of(context)
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
/*                      _isLoading ? CircularProgressIndicator() :*/
                          GestureDetector(
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
        ],
      ),
    );
  }
}
