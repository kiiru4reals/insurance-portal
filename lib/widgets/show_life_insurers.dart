import 'package:flutter/material.dart';
import 'package:insurance_portal/models/life_insurer_attr.dart';
import 'package:provider/provider.dart';

class ShowLifeInsurers extends StatefulWidget {
  final String lifeinsurerId;

  const ShowLifeInsurers({Key? key, required this.lifeinsurerId}) : super(key: key);

  @override
  _ShowLifeInsurersState createState() => _ShowLifeInsurersState();
}

class _ShowLifeInsurersState extends State<ShowLifeInsurers> {
  @override
  Widget build(BuildContext context) {
    final luAttr = Provider.of<LifeInsurer>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            luAttr.packageName,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
/*                          Text(
                            CarAttr.expiry_date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // positionedRemove(widget.productId),
      ],
    );
  }
}
