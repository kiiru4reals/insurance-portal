import 'package:insurance_portal/auth/login.dart';
import 'package:insurance_portal/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print('The user is already logged in');
              return MainScreen();
            } else {
              print('The user didn\'t login yet');
              return LoginScreen();
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text('Error occured'),
            );
          }
          return const SizedBox();
        });
  }
}