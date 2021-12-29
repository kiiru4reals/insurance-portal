import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/screens/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              // SizedBox(
              //   height: 60,
              // ),
              Image.asset('assets/images/logo.png'),
              /*SizedBox(
                height: 15,
              ),*/
              Text(
                'Hillenburg Insurance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              /*SizedBox(
                height: 30,
              ),*/
              Container(
                height: 400,
                width: 480,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*SizedBox(height: 30,),
                    Text("Hello", style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,

                    ),),*/
                    SizedBox(height: 30,),
                    Text("Enter username and password",style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text('Email Address'),
                          prefixIcon: Icon(Icons.email_outlined,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Password'),
                          prefixIcon: Icon(Icons.password_outlined,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*Text("Forgot password?", style: TextStyle(
                          color: Colors.orangeAccent[700],
                        ),),*/
                      ],
                    ),),
                    // SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ColorConsts.gradientButtonLeft, ColorConsts.gradientButtonRight]
                          ),
                        ),
                        child: Padding(padding: EdgeInsets.all(12.0),
                        child: Text("Login", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),),
                      ),
                    ),
                    SizedBox(height: 30,),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
