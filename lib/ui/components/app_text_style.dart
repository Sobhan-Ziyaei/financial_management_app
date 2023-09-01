import 'package:flutter/material.dart';
import 'package:work_report_app/gen/fonts.gen.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';

class AppLightTextStyle {
  static const TextStyle appMainTitle = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 14,
    color: AppColors.black,
  );

  static const TextStyle appMainTitleInRed = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 16,
    color: AppColors.red,
  );
  static const TextStyle appGreenButton = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 11,
    color: AppColors.white,
  );
  static const TextStyle appModifyButton = TextStyle(
    color: AppColors.white,
    fontFamily: FontFamily.mr,
    fontSize: 10,
  );

  static const TextStyle appSmallBlackButton = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 7,
    color: AppColors.white,
  );
  static const TextStyle appLargeBlackButton = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 11,
    color: AppColors.white,
  );

  static const TextStyle appTextFieldContent = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 12,
    color: AppColors.black,
  );

  static const TextStyle appCardItemTitle = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 14,
    color: AppColors.cardItemTitle,
  );

  static const TextStyle appCardItemContent1 = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 10,
    color: AppColors.cardItemContent,
  );

  static const TextStyle appCardItemContent2 = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 10,
    color: AppColors.green,
  );

  static const TextStyle appSplashScreenLogo = TextStyle(
    fontFamily: FontFamily.mr,
    fontSize: 14,
    color: AppColors.black,
  );
}
