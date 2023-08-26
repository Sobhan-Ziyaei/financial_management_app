import 'package:flutter/material.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/app_modify_text_field.dart';
import 'package:work_report_app/ui/widgets/buttons/app_green_button.dart';

class ModifyFinancialItemScreen extends StatefulWidget {
  ModifyFinancialItemScreen(
      {Key? key,
      required this.defaultTitle,
      required this.defaultDescription,
      required this.id,
      required this.costsNotifier,
      required this.selectedCategory})
      : super(key: key);
  final String defaultTitle;
  final String defaultDescription;
  final int id;
  final ValueNotifier costsNotifier;
  final UserItem selectedCategory;
  @override
  State<ModifyFinancialItemScreen> createState() => _ModifyFinancialItemScreenState();
}

class _ModifyFinancialItemScreenState extends State<ModifyFinancialItemScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  final financialItemBox = objectBox.store.box<UserFinancialItem>();
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
          title: AppStrings.modifyCategory,
          size: size),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                AppModifyTextField(
                    hint: widget.defaultTitle,
                    title: AppStrings.title,
                    controller: titleController,
                    focusNode: titleFocusNode),
                const SizedBox(
                  height: 30,
                ),
                AppModifyTextField(
                    hint: widget.defaultDescription,
                    title: AppStrings.description,
                    controller: descriptionController,
                    focusNode: descriptionFocusNode),
                const SizedBox(
                  height: 30,
                ),
                AppGreenButton(
                    onPressed: () {
                      modifyCategory(widget.id, titleController.text,
                          descriptionController.text);
                      Navigator.pop(context, true);
                    },
                    text: AppStrings.modify)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void modifyCategory(int id, String price, String description) {
    var finantialItem = UserFinancialItem(id: id,amount: price,description: description);
    finantialItem.item.target = widget.selectedCategory;
    financialItemBox.put(finantialItem);
    widget.costsNotifier.value = financialItemBox.getAll();
  }
}
