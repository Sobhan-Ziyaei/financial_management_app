import 'package:flutter/material.dart';
import 'package:work_report_app/route/names.dart';
import 'package:work_report_app/ui/screens/cost/cost_category_screen.dart';
import 'package:work_report_app/ui/screens/cost/cost_screen.dart';
import 'package:work_report_app/ui/screens/definitions_screen.dart';
import 'package:work_report_app/ui/screens/financial_item/finantial_item_type_screen.dart';
import 'package:work_report_app/ui/screens/home_screen.dart';
import 'package:work_report_app/ui/screens/income/income_category_screen.dart';
import 'package:work_report_app/ui/screens/income/income_screen.dart';
import 'package:work_report_app/ui/screens/report/report_type_screen.dart';
import 'package:work_report_app/ui/screens/splash_screen.dart';
import 'package:work_report_app/ui/screens/work/work_category_screen.dart';
import 'package:work_report_app/ui/screens/work/work_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.root: (context) => SplashScreen(),
  ScreenNames.homeScreen: (context) => HomeScreen(),
  ScreenNames.definitionsScreen: (context) => DefinitionsScreen(),
  ScreenNames.costCategoryScreen: (context) => CostCategoryScreen(),
  ScreenNames.costScreen: (context) => CostScreen(),
  ScreenNames.incomeScreen: (context) => IncomeScreen(),
  ScreenNames.incomeCategoryScreen: (context) => IncomeCategoryScreen(),
  ScreenNames.financialItemTypeScreen: (context) => FinancialItemTypeScreen(),
  ScreenNames.workCategoryScreen: (context) => WorkCategoryScreen(),
  ScreenNames.workScreen: (context) => WorkScreen(),
  ScreenNames.reportTypeScreen: (context) => ReportTypeScreen(),
};
