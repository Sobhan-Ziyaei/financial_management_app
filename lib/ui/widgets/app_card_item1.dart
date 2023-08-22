import 'package:flutter/material.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';

class AppCardItem1 extends StatelessWidget {
  final String mainTitle;
  final String title;
  final String description;
  final String price;
  AppCardItem1(
      {required this.mainTitle,
      required this.title,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: size.height * 0.2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            mainTitle,
            style: AppLightTextStyle.appCardItemTitle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$title :   ', style: AppLightTextStyle.appCardItemContent1),
              const Text(AppStrings.title,
                  style: AppLightTextStyle.appCardItemContent2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$description :   ',
                  style: AppLightTextStyle.appCardItemContent1),
              const Text(AppStrings.description,
                  style: AppLightTextStyle.appCardItemContent2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$price :   ', style: AppLightTextStyle.appCardItemContent1),
              const Text(AppStrings.price,
                  style: AppLightTextStyle.appCardItemContent2),
            ],
          ),
        ],
      ),
    );
  }
}
