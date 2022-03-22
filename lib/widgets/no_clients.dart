import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/screens/main_screen.dart';

class NoClients extends StatefulWidget {
  const NoClients({Key? key}) : super(key: key);

  @override
  _NoClientsState createState() => _NoClientsState();
}

class _NoClientsState extends State<NoClients> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height*.4,
          decoration: BoxDecoration(image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/emptywishlist.png')
          ),
          ),
        ),
        Text('You got no clients :(',
          style: TextStyle(color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50,),
        Text('Sell some more maybe?',
          style: TextStyle(
              color: ColorConsts.subTitle,
              fontSize: 26,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 50,
        ),
        Container(

          width: MediaQuery.of(context).size.width*.9,
          height: MediaQuery.of(context).size.height*.06,
          child: ElevatedButton(onPressed: () => Navigator.of(context).pushNamed(MainScreen.routeName),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.cyanAccent.shade400)
                ),
                primary: Colors.redAccent,
              ),
              child: Text('Go home'.toUpperCase(),
                style: TextStyle(color: ColorConsts.subTitle,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              )
          ),
        ),
      ],
    );
  }
}
