import 'package:flutter/material.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/app_main_text_field.dart';
import 'package:work_report_app/ui/widgets/buttons/app_green_button.dart';

class RegisterFinantialItemScreen extends StatefulWidget {
  RegisterFinantialItemScreen(
      {Key? key, required this.itemTitle, required this.itemNotifier})
      : super(key: key);
  UserItem itemTitle;
  final ValueNotifier itemNotifier;
  @override
  State<RegisterFinantialItemScreen> createState() =>
      _RegisterFinantialItemScreenState();
}

class _RegisterFinantialItemScreenState
    extends State<RegisterFinantialItemScreen> {
  final financialItemBox = objectBox.store.box<UserFinancialItem>();
  final itemBox = objectBox.store.box<UserItem>();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode priceNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  @override
  void initState() {
    super.initState();

    priceNode.addListener(() {
      setState(() {});
    });

    descriptionNode.addListener(() {
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
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: widget.itemTitle.title ?? '',
          size: size),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                AppMainTextField(
                  inputType: TextInputType.number,
                  title: AppStrings.price,
                  controller: priceController,
                  focusNode: priceNode,
                ),
                const SizedBox(height: 50),
                AppMainTextField(
                  inputType: TextInputType.number,
                  title: AppStrings.description,
                  controller: descriptionController,
                  focusNode: descriptionNode,
                ),
                const SizedBox(height: 50),
                AppGreenButton(
                    onPressed: () {
                      addFinancialItem(
                          priceController.text, descriptionController.text);
                    },
                    text: AppStrings.save)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addFinancialItem(String price, String description) {
    var financialItem =
        UserFinancialItem(amount: price, description: description);
    financialItem.item.target = widget.itemTitle;
    financialItemBox.put(financialItem);
    UserItem item = UserItem();
    item.financialItem.add(financialItem);
    itemBox.put(item);
    widget.itemNotifier.value = financialItemBox.getAll();
    Navigator.pop(context, true);
  }
}
