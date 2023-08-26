import 'package:flutter/material.dart';
import 'package:work_report_app/route/names.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/buttons/app_green_button.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';

class DefinitionsScreen extends StatefulWidget {
  DefinitionsScreen({Key? key}) : super(key: key);

  @override
  State<DefinitionsScreen> createState() => _DefinitionsScreenState();
}

class _DefinitionsScreenState extends State<DefinitionsScreen> {
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
          title: AppStrings.definitions,
          size: size),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              AppStrings.costs,
              style: AppLightTextStyle.appMainTitle,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ScreenNames.costCategoryScreen);
                    },
                    text: AppStrings.costCategory),
                AppGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenNames.costScreen);
                    },
                    text: AppStrings.costs)
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              AppStrings.incomes,
              style: AppLightTextStyle.appMainTitle,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ScreenNames.incomeCategoryScreen);
                    },
                    text: AppStrings.incomeCategory),
                AppGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenNames.incomeScreen);
                    },
                    text: AppStrings.incomes),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              AppStrings.works,
              style: AppLightTextStyle.appMainTitle,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ScreenNames.workCategoryScreen);
                    },
                    text: AppStrings.workCategory),
                AppGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenNames.workScreen);
                    },
                    text: AppStrings.works)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
