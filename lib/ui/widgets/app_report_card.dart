import 'package:flutter/material.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';

class AppReportCard extends StatelessWidget {
  final String category;
  final String date;
  final String title;
  final String amount;
  final String description;
  AppReportCard({
    required this.category,
    required this.description,
    required this.title,
    required this.amount,
    required this.date,
  });

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(category, style: AppLightTextStyle.appMainTitle),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$title :   ', style: AppLightTextStyle.appCardItemContent1),
              const Text(AppStrings.category,
                  style: AppLightTextStyle.appCardItemContent2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$date :   ', style: AppLightTextStyle.appCardItemContent1),
              const Text(AppStrings.date,
                  style: AppLightTextStyle.appCardItemContent2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$amount :   ',
                  style: AppLightTextStyle.appCardItemContent1),
              const Text(AppStrings.price,
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
        ],
      ),
    );
  }
}
