import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/widgets/scrollable_widget.dart';

class VehicleUnderwriters extends StatefulWidget {
  static const routeName = "/VehicleUnderwriters";

  @override
  _VehicleUnderwritersState createState() => _VehicleUnderwritersState();
}

class _VehicleUnderwritersState extends State<VehicleUnderwriters> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConsts.bgColor,
        centerTitle: true,
        title: Text("Vehicle insurers"),
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Vehicle insurers")
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          if (querySnapshot.hasError)
            return Center(
              child: Text("Some error occurred."),
            );
          if (querySnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final list = querySnapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list[index]["insurerName"]),
                );
              },
              itemCount: list.length,
            );
          }
        },
      )),
    );
  }
}
