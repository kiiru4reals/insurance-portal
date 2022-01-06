import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:insurance_portal/constants/color.dart';


class CloudStorageInfo {
  final String? title, totalStorage;
  final icon;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.icon,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Vehicle Insurance",
    numOfFiles: 10,
    icon: FontAwesome5.car_crash,
    totalStorage: "1.9GB",
    color: ColorConsts.primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Life insurance",
    numOfFiles: 12,
    icon: FontAwesome5.heartbeat,
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 20,
  ),
  CloudStorageInfo(
    title: "Marine Insurance",
    numOfFiles: 2,
    icon: Icons.sailing,
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 8,
  ),
];
