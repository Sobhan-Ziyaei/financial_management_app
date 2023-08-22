import 'package:flutter/material.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';

class AppButton3 extends StatelessWidget {
  final String text;
  AppButton3({required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColors.green,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: AppLightTextStyle.appButton3,
          ),
        ),
      ),
    );
  }
}
