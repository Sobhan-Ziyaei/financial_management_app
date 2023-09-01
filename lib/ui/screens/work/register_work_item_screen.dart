import 'package:flutter/material.dart';
import 'package:persian_horizontal_date_picker/persian_horizontal_date_picker.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';

class RegisterWorkItemScreen extends StatefulWidget {
  RegisterWorkItemScreen({Key? key}) : super(key: key);

  @override
  State<RegisterWorkItemScreen> createState() => _RegisterWorkItemScreenState();
}

class _RegisterWorkItemScreenState extends State<RegisterWorkItemScreen> {
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
          title: AppStrings.registerNewWork,
          size: size),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            PersianHorizontalDatePicker(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 30)),
              initialSelectedDate: DateTime.now(),
              onDateSelected: (date) {},
            )
          ],
        ),
      ),
    );
  }
}
