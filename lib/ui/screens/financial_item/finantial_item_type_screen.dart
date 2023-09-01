import 'package:flutter/material.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/screens/financial_item/item_list_screen.dart';
import 'package:work_report_app/ui/screens/register_screen.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/buttons/app_large_black_button.dart';

class FinancialItemTypeScreen extends StatefulWidget {
  FinancialItemTypeScreen({Key? key}) : super(key: key);

  @override
  State<FinancialItemTypeScreen> createState() =>
      _FinancialItemTypeScreenState();
}

class _FinancialItemTypeScreenState extends State<FinancialItemTypeScreen> {
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
          title: AppStrings.registerNewFinancialItem,
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
                          RegisterScreen(type: AppStrings.cost),
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
                          RegisterScreen(type: AppStrings.income),
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
                          RegisterScreen(type: AppStrings.work),
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
