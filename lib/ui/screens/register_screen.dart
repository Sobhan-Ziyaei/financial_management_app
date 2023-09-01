import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/objectbox.g.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/app_main_text_field.dart';
import 'package:work_report_app/ui/widgets/buttons/app_green_button.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key, required this.type}) : super(key: key);
  String type;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final categortBox = objectBox.store.box<UserCategory>();
  final itemBox = objectBox.store.box<UserItem>();
  final financialItemBox = objectBox.store.box<UserFinancialItem>();
  List<UserCategory> categoryList = [];
  List<UserItem> itemList = [];
  UserCategory? selectedCategory;
  UserItem? selectedItem;
  DateTime? selectedDay;
  String? userYear;
  String? userMonth;
  String? userDay;
  Jalali? userJalali ;
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode priceNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  @override
  void initState() {
    super.initState();
    getCategoryData();

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
        title: 'ثبت',
        size: size,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  DropdownButtonFormField<UserCategory>(
                    value: selectedCategory,
                    items: categoryList.map(
                      (category) {
                        return DropdownMenuItem<UserCategory>(
                          value: category,
                          child: Text(category.title!),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          selectedCategory = value;
                          itemList.clear();
                          selectedItem = null;
                          getItemData();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  DropdownButtonFormField<UserItem>(
                    value: selectedItem,
                    items: itemList.map(
                      (item) {
                        return DropdownMenuItem<UserItem>(
                          value: item,
                          child: Text(item.title!),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          selectedItem = value;
                        },
                      );
                    },
                  ),
                  // DropdownSearch<UserItem>(
                  //   selectedItem: selectedItem,
                  //   items: itemList,
                  //   popupProps: PopupProps.menu(
                  //     itemBuilder: (context, item, isSelected) {
                  //       return Text(item.title!);
                  //     },
                  //   ),
                  //   onChanged: (value) {
                  //     setState(
                  //       () {
                  //         selectedItem = value;
                  //       },
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 50),
                  AppMainTextField(
                    title: AppStrings.price,
                    controller: priceController,
                    focusNode: priceNode,
                  ),
                  const SizedBox(height: 50),
                  AppMainTextField(
                    title: AppStrings.description,
                    controller: descriptionController,
                    focusNode: descriptionNode,
                  ),
                  const SizedBox(height: 50),
                  // PersianHorizontalDatePicker(
                  //   startDate: DateTime.now(),
                  //   endDate: DateTime.now().add(const Duration(days: 30)),
                  //   initialSelectedDate: DateTime.now(),
                  //   onDateSelected: (date) {
                  //     setState(() {
                  //       selectedDay = date;
                  //     });
                  //   },
                  // ),
                  LinearDatePicker(
                    isJalaali: true,
                    dateChangeListener: (String selectedDate) {
                      var x = selectedDate.split('/');
                      //print(x);
                      //print(selectedDate);
                      int year = int.parse(x[0]);
                      int month = int.parse(x[1]);
                      int day = int.parse(x[2]);
                      Jalali j = Jalali(year, month, day);
                      DateTime j2dt = j.toDateTime();
                      print(j2dt);
                      setState(() {
                        userYear = x[0];
                        userMonth = x[1];
                        userDay = x[2];
                      });
                      //DateTime dateTime = DateTime(year, month, day);
                      //print(dateTime);
                      setState(() {
                        selectedDay = j2dt;
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                  AppGreenButton(
                      onPressed: () {
                        saveData(
                            priceController.text, descriptionController.text);
                        print(selectedDay);
                        print(userDay);
                      },
                      text: AppStrings.save),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getCategoryData() {
    QueryBuilder<UserCategory> builder =
        categortBox.query(UserCategory_.type.equals(widget.type));
    Query<UserCategory> query = builder.build();
    for (var element in query.find()) {
      categoryList.add(element);
    }
  }

  void getItemData() {
    QueryBuilder<UserItem> builder = itemBox.query();
    builder.link(UserItem_.category,
        UserCategory_.title.equals(selectedCategory!.title!));
    Query<UserItem> query = builder.build();
    for (var element in query.find()) {
      itemList.add(element);
    }
  }

  void saveData(String amount, String description) {
    var financialItem = UserFinancialItem();
    financialItem.amount = amount;
    financialItem.description = description;
    financialItem.date = selectedDay;
    financialItem.year = userYear;
    financialItem.month = userMonth;
    financialItem.day = userDay;
    financialItem.item.target = selectedItem;
    financialItemBox.put(financialItem);
    Navigator.pop(context, true);
  }
}
