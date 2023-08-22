import 'package:flutter/material.dart';
import 'package:work_report_app/route/names.dart';
import 'package:work_report_app/ui/screens/home_screen.dart';
import 'package:work_report_app/ui/screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.root: (context) => SplashScreen(),
  ScreenNames.homeScreen: (context) => const HomeScreen(),
};
