import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/app_main_text_field.dart';
import 'package:work_report_app/ui/widgets/buttons/app_green_button.dart';

class RegisterCategoryScreen extends StatefulWidget {
  RegisterCategoryScreen({Key? key, required this.type,required this.categoriesNotifier}) : super(key: key);
  String? type;
  final ValueNotifier categoriesNotifier;
  @override
  State<RegisterCategoryScreen> createState() => _RegisterCategoryScreenState();
}

class _RegisterCategoryScreenState extends State<RegisterCategoryScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    titleFocusNode.addListener(() {
      setState(() {});
    });

    descriptionFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppMainAppBar(
          icon: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: AppStrings.registerNewCategory,
          size: size),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                widget.type!,
                style: AppLightTextStyle.appMainTitle,
              ),
              const SizedBox(height: 50),
              AppMainTextField(
                  title: AppStrings.title,
                  controller: titleController,
                  focusNode: titleFocusNode),
              const SizedBox(height: 50),
              AppMainTextField(
                  title: AppStrings.description,
                  controller: descriptionController,
                  focusNode: descriptionFocusNode),
              const SizedBox(height: 50),
              AppGreenButton(
                  onPressed: () {
                    final category = UserCategory(
                      type: widget.type,
                      title: titleController.text,
                      description: descriptionController.text,
                    );
                    final categoryBox = objectBox.store.box<UserCategory>();
                    categoryBox.put(category);
                    widget.categoriesNotifier.value = categoryBox.getAll();
                    Navigator.pop(context,true);
                  },
                  text: AppStrings.save)
            ],
          ),
        ),
      ),
    );
  }
}
