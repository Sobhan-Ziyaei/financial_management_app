import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/gen/fonts.gen.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_card_item3.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final financialItemBox = objectBox.store.box<UserFinancialItem>();
  late List<UserFinancialItem> financialItemList = [];
  TextEditingController titleController = TextEditingController();
  FocusNode titleNode = FocusNode();

  @override
  void initState() {
    getData2();
    super.initState();
    titleNode.addListener(() {
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
          title: '${AppStrings.report} ${widget.type}',
          size: size),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        filterList(value);
                      },
                      keyboardType: TextInputType.text,
                      style: AppLightTextStyle.appTextFieldContent,
                      controller: titleController,
                      focusNode: titleNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        labelText:
                            '${AppStrings.title} ${widget.type} ${AppStrings.reportSearchTitle}',
                        labelStyle: TextStyle(
                            fontFamily: FontFamily.mr,
                            fontSize: 14,
                            color: titleNode.hasFocus
                                ? AppColors.textFieldColor1
                                : AppColors.textFieldColor2),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor2, width: 3.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: AppColors.textFieldColor1,
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 50),
              ListView.builder(
                shrinkWrap: true,
                itemCount: financialItemList.length,
                itemBuilder: (context, index) {
                  return AppCardItem3(
                    category: financialItemList[index].item.target?.title ?? '',
                    title: financialItemList[index].amount ?? '',
                    description: financialItemList[index].description ?? '',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void getData2() {
    QueryBuilder<UserFinancialItem> builder = financialItemBox.query();
    Query<UserFinancialItem> query = builder.build();

    for (var element in query.find()) {
      if (element.item.target?.type == widget.type) {
        financialItemList.add(element);
      }
    }
  }

  void filterList(String enterKeyword) {
    List<UserFinancialItem> itemFinancialListResult = [];
    if (enterKeyword.isEmpty) {
      financialItemList.clear();
      getData2();
    }
    itemFinancialListResult = financialItemList.where((element) {
      return element.item.target!.title!
          .toLowerCase()
          .contains(enterKeyword.toLowerCase());
    }).toList();

    setState(() {
      financialItemList = itemFinancialListResult;
    });
  }
}
