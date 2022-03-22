import 'package:flutter/material.dart';
import 'package:insurance_portal/models/life_models.dart';
import 'package:provider/provider.dart';

class ShowLifeClients extends StatefulWidget {
  final String lifeId;

  const ShowLifeClients({Key? key, required this.lifeId}) : super(key: key);

  @override
  _ShowLifeClientsState createState() => _ShowLifeClientsState();
}

class _ShowLifeClientsState extends State<ShowLifeClients> {
  @override
  Widget build(BuildContext context) {
    final lcAttr = Provider.of<Life>(context);
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
/*                    Container(
                      height: 80,
                      child: Image.network(CarAttr.certificateUrl),
                    ),*/
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                lcAttr.firstName,
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                lcAttr.lastName,
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ],
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
      ],
    );
  }
}
