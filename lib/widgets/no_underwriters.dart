import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/routes/underwriter_options.dart';

class NoUnderWriters extends StatefulWidget {
  const NoUnderWriters({Key? key}) : super(key: key);

  @override
  _NoUnderWritersState createState() => _NoUnderWritersState();
}

class _NoUnderWritersState extends State<NoUnderWriters> {
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
        Text('You have no underwriters',
          style: TextStyle(color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50,),
        Text('Add an underwriter?',
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
          child: ElevatedButton(onPressed: () => Navigator.of(context).pushNamed(SelectUnderwriter.routeName),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.cyanAccent.shade400)
                ),
                primary: Colors.redAccent,
              ),
              child: Text('Get Started'.toUpperCase(),
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