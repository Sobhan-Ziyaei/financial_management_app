import 'package:flutter/material.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/route/names.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/screens/item_screen.dart';
import 'package:work_report_app/ui/screens/register_screen.dart';
import 'package:work_report_app/ui/widgets/buttons/app_large_black_button.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/buttons/app_small_black_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final itemBox = objectBox.store.box<UserItem>();
  final itemNotifier = ValueNotifier([]);
  @override
  void initState() {
    itemNotifier.value = itemBox.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppMainAppBar(
          icon: const SizedBox(),
          title: AppStrings.homeScreenAppbarTitle,
          size: size),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            AppLargeBlackButton(
                onPressed: () {
                  Navigator.pushNamed(context, ScreenNames.definitionsScreen);
                },
                text: AppStrings.definitions),
            const SizedBox(height: 50),
            AppLargeBlackButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, ScreenNames.financialItemTypeScreen);
                },
                text: AppStrings.registerNewFinancialItem),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppSmallBlackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                              type: AppStrings.work,
                              itemNotifier: itemNotifier),
                        ),
                      );
                    },
                    text: AppStrings.registerWork),
                AppSmallBlackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                              type: AppStrings.income,
                              itemNotifier: itemNotifier),
                        ),
                      );
                    },
                    text: AppStrings.registerIncome),
                AppSmallBlackButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                              type: AppStrings.cost,
                              itemNotifier: itemNotifier),
                        ),
                      );
                    },
                    text: AppStrings.registerCost),
              ],
            ),
            const SizedBox(height: 50),
            AppLargeBlackButton(
                onPressed: () {
                  Navigator.pushNamed(context, ScreenNames.reportTypeScreen);
                },
                text: AppStrings.reports),
          ],
        ),
      ),
    );
  }
}
