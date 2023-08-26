import 'package:flutter/material.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/screens/financial_item/item_list_screen.dart';
import 'package:work_report_app/ui/screens/report/report_screen.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/buttons/app_large_black_button.dart';

class ReportTypeScreen extends StatefulWidget {
  ReportTypeScreen({Key? key}) : super(key: key);

  @override
  State<ReportTypeScreen> createState() => _ReportTypeScreenState();
}

class _ReportTypeScreenState extends State<ReportTypeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppMainAppBar(
          icon: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: AppStrings.reports,
          size: size),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            AppLargeBlackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReportScreen(type: AppStrings.cost),
                    ),
                  );
                },
                text: AppStrings.cost),
            const SizedBox(height: 50),
            AppLargeBlackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReportScreen(type: AppStrings.income),
                    ),
                  );
                },
                text: AppStrings.income),
            const SizedBox(height: 50),
            AppLargeBlackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReportScreen(type: AppStrings.work),
                    ),
                  );
                },
                text: AppStrings.work),
          ],
        ),
      ),
    );
  }
}
