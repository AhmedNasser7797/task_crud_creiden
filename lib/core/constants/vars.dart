import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class UtilsConstants {
  UtilsConstants._();

  static final UtilsConstants _instance = UtilsConstants._();

  factory UtilsConstants() => _instance;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String dateFormat = 'dd-MM-yyyy';
}

const weekdayLabels = [
  "السبت",
  "الأحد",
  "الإثنين",
  "الثلاثاء",
  "الأربعاء",
  "الخميس",
  "الجمعة"
];
const everyPeriod = [
  '۱٥ دقيقة',
  '۳۰ دقيقة',
  '٤٥ دقيقة',
  '٦۰ دقيقة',
];
