import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
class VehicleInsurerDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> post;
  VehicleInsurerDetails({ required this.post});
  @override
  _VehicleInsurerDetailsState createState() => _VehicleInsurerDetailsState();
}

class _VehicleInsurerDetailsState extends State<VehicleInsurerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConsts.bgColor,
        title: Text(widget.post.data()!["insurerName"]),
      ),
    );
  }
}