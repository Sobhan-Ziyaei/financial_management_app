

import 'package:flutter/material.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';

class AppMainScreenButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  AppMainScreenButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.07,
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(AppColors.mainScreenButtonBackground),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: AppLightTextStyle.appButton2,
          ),
        ),
      ),
    );
  }
}
