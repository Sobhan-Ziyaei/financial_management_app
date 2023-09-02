import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/gen/fonts.gen.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/objectbox.g.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/app_report_card.dart';
import 'package:work_report_app/ui/widgets/buttons/app_small_black_button.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final financialItemBox = objectBox.store.box<UserFinancialItem>();
  final itemBox = objectBox.store.box<UserItem>();
  late List<UserFinancialItem> financialItemList = [];
  TextEditingController titleController = TextEditingController();
  FocusNode titleNode = FocusNode();
  List<Jalali> jalaliList = [];
  DateTime? firstDateInput;
  DateTime? lastDateInput;
  Jalali? firstInput;
  Jalali? lastInput;
  bool dateStartSelecte = false;
  bool dateEndSelecte = false;
  UserFinancialItem largestItem = UserFinancialItem();
  @override
  void initState() {
    getFinancialItemData();
    biggestAmount();
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
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: size.width,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border:
                        Border.all(width: 2, color: AppColors.textFieldColor2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () async {
                          Jalali? picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1385, 8),
                            lastDate: Jalali(1450, 9),
                          );
                          setState(() {
                            firstDateInput = picked?.toDateTime();
                            firstInput = picked;
                            dateStartSelecte = true;
                          });
                        },
                        icon: const Icon(Icons.calendar_month_rounded)),
                    const Spacer(),
                    Visibility(
                      visible: dateStartSelecte,
                      child: Text(
                        '${firstInput?.year} / ${firstInput?.month} / ${firstInput?.day}',
                        style: AppLightTextStyle.appCardItemContent1,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      ':  ${AppStrings.setStartDate}',
                      style: AppLightTextStyle.appTextFieldContent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: size.width,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border:
                        Border.all(width: 2, color: AppColors.textFieldColor2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.now(),
                          firstDate: Jalali(1385, 8),
                          lastDate: Jalali(1450, 9),
                        );
                        setState(() {
                          lastDateInput = picked?.toDateTime();
                          lastInput = picked;
                          dateEndSelecte = true;
                        });
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: dateEndSelecte,
                      child: Text(
                        '${lastInput?.year} / ${lastInput?.month} / ${lastInput?.day}',
                        style: AppLightTextStyle.appCardItemContent1,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      ':  ${AppStrings.setEndDate}',
                      style: AppLightTextStyle.appTextFieldContent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppSmallBlackButton(
                    onPressed: () {
                      getFinancialItemDataInCustomDate();
                      setState(() {});
                    },
                    text: AppStrings.filterDate,
                  ),
                  AppSmallBlackButton(
                    onPressed: () {
                      getFinancialItemData();
                      setState(() {
                        dateStartSelecte = false;
                        dateEndSelecte = false;
                      });
                    },
                    text: AppStrings.deleteFilterDate,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                AppStrings.biggestAmount,
                style: AppLightTextStyle.appMainTitleInRed,
              ),
              AppReportCard(
                category: largestItem.item.target?.title ?? '',
                title: largestItem.item.target?.category.target?.title ?? '',
                description: largestItem.description ?? '',
                amount: largestItem.amount ?? '',
                date:
                    '${largestItem.date!.toJalali().year.toString()} / ${largestItem.date!.toJalali().month.toString()} / ${largestItem.date!.toJalali().day.toString()}',
              ),
              const Text(
                AppStrings.thisMonth,
                style: AppLightTextStyle.appMainTitleInRed,
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: financialItemList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      financialItemBox.remove(financialItemList[index].id);
                    },
                    child: AppReportCard(
                      category:
                          financialItemList[index].item.target?.title ?? '',
                      title: financialItemList[index]
                              .item
                              .target
                              ?.category
                              .target
                              ?.title ??
                          '',
                      description: financialItemList[index].description ?? '',
                      amount: financialItemList[index].amount ?? '',
                      date:
                          '${jalaliList[index].year.toString()} / ${jalaliList[index].month.toString()} / ${jalaliList[index].day.toString()}',
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void getData() {
    QueryBuilder<UserFinancialItem> builder = financialItemBox.query();
    builder.link(UserFinancialItem_.item, UserItem_.type.equals(widget.type));
    Query<UserFinancialItem> query = builder.build();
  }

  void biggestAmount() {
    QueryBuilder<UserFinancialItem> builder = financialItemBox.query();
    builder.link(UserFinancialItem_.item, UserItem_.type.equals(widget.type));
    builder.order(UserFinancialItem_.amount, flags: Order.descending);

    Query<UserFinancialItem> query = builder.build();
    UserFinancialItem? biggestItem = query.findFirst();
    setState(() {
      largestItem = biggestItem!;
    });
  }

  void getFinancialItemData() {
    Jalali today = Jalali.now();
    Jalali firstDay = Jalali(today.year, today.month, 1);
    Jalali lastDay = Jalali(today.year, today.month, 30);
    DateTime fistDayInDateTime = firstDay.toDateTime();
    DateTime lastDayInDateTime = lastDay.toDateTime();
    int firstDayOfMonthInInt = fistDayInDateTime.millisecondsSinceEpoch;
    int lastDayOfMonthInInt = lastDayInDateTime.millisecondsSinceEpoch;
    financialItemList.clear();
    jalaliList.clear();
    QueryBuilder<UserFinancialItem> builder = financialItemBox.query(
        UserFinancialItem_.date
            .between(firstDayOfMonthInInt, lastDayOfMonthInInt));
    builder.link(UserFinancialItem_.item, UserItem_.type.equals(widget.type));
    Query<UserFinancialItem> query = builder.build();
    for (var element in query.find()) {
      financialItemList.add(element);
      jalaliList.add(element.date!.toJalali());
    }
  }

  void getFinancialItemDataInCustomDate() {
    int firstDayInInt = firstDateInput!.millisecondsSinceEpoch;
    int lastDayInInt = lastDateInput!.millisecondsSinceEpoch;
    financialItemList.clear();
    jalaliList.clear();
    QueryBuilder<UserFinancialItem> builder = financialItemBox
        .query(UserFinancialItem_.date.between(firstDayInInt, lastDayInInt));
    builder.link(UserFinancialItem_.item, UserItem_.type.equals(widget.type));
    Query<UserFinancialItem> query = builder.build();
    for (var element in query.find()) {
      financialItemList.add(element);
      jalaliList.add(element.date!.toJalali());
    }
  }

  void filterList(String enterKeyword) {
    List<UserFinancialItem> itemFinancialListResult = [];
    if (enterKeyword.isEmpty) {
      financialItemList.clear();
      getFinancialItemData();
    }
    itemFinancialListResult = financialItemList.where(
      (element) {
        return element.item.target!.title!
            .toLowerCase()
            .contains(enterKeyword.toLowerCase());
      },
    ).toList();

    setState(
      () {
        financialItemList = itemFinancialListResult;
      },
    );
  }
}
