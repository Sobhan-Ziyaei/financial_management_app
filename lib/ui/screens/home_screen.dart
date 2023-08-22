import 'package:flutter/material.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_button2.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            const SizedBox(height: 30),
            AppButton2(
                onPressed: () {
                  //Navigator.pushNamed(context, ScreenNames.setScreen);
                },
                text: 'تعاریف'),
            const SizedBox(height: 20),
            AppButton2(
                onPressed: () {
                  //Navigator.pushNamed(context, ScreenNames.reportScreen);
                },
                text: 'گزارشات'),
          ],
        ),
      ),
    );
  }
}
