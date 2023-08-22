import 'package:flutter/material.dart';
import 'package:work_report_app/gen/fonts.gen.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';

class AppMainTextField extends StatelessWidget {
  final String title;
  TextEditingController controller;
  FocusNode focusNode;
  TextInputType inputType;
  final String hint;
  AppMainTextField({
    this.hint = '',
    required this.title,
    required this.controller,
    required this.focusNode,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      style: AppLightTextStyle.appTextFieldContent,
      controller: controller..text = hint,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: title,
        labelStyle: TextStyle(
            fontFamily: FontFamily.mr,
            fontSize: 14,
            color: focusNode.hasFocus
                ? AppColors.textFieldColor1
                : AppColors.textFieldColor2),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: AppColors.textFieldColor2, width: 3.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            width: 3,
            color: AppColors.textFieldColor1,
          ),
        ),
      ),
    );
  }
}
