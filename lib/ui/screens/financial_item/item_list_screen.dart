import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/screens/financial_item/modify_financial_item_screnn.dart';
import 'package:work_report_app/ui/screens/financial_item/register_finantial_item.dart';
import 'package:work_report_app/ui/widgets/app_card_item2.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/buttons/app_large_black_button.dart';

class ItemListScreen extends StatefulWidget {
  ItemListScreen({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final financialItemNotifier = ValueNotifier<List<UserFinancialItem>>([]);
  final itemBox = objectBox.store.box<UserItem>();
  final financialItemBox = objectBox.store.box<UserFinancialItem>();
  List<UserItem> itemList = [];
  List<UserFinancialItem> financialItemList = [];
  String selectedTitle = '';
  String selectedDescription = '';
  int? selectedId;
  UserItem? selectedFinancialItem;
  @override
  void initState() {
    getData();
    getData2();
    financialItemNotifier.value = financialItemList;
    super.initState();
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
          title: AppStrings.registerNewCostFinancialItem,
          size: size),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // AppSmallBlackButton(
              //     onPressed: () {
              //       itemBox.removeAll();
              //     },
              //     text: 'Remove'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppLargeBlackButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterFinantialItemScreen(
                                itemTitle: itemList[index],
                                itemNotifier: financialItemNotifier,
                              ),
                            ),
                          ).then((value) {
                            if (value == true) {
                              financialItemList.clear();
                              getData2();
                            }
                          });
                        },
                        text: itemList[index].title ?? ''),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(AppStrings.categoryList,
                  style: AppLightTextStyle.appMainTitle),
              ValueListenableBuilder(
                valueListenable: financialItemNotifier,
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: financialItemList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          financialItemBox.remove(financialItemList[index].id);
                        },
                        child: AppCardItem2(
                          category:
                              financialItemList[index].item.target?.title ?? '',
                          title: financialItemList[index].amount ?? '',
                          description:
                              financialItemList[index].description ?? '',
                          modify: InkWell(
                            onTap: () {
                              setState(() {
                                selectedId = financialItemList[index].id;
                                selectedTitle =
                                    financialItemBox.get(selectedId!)!.amount!;
                                selectedDescription = financialItemBox
                                    .get(selectedId!)!
                                    .description!;
                                selectedFinancialItem =
                                    financialItemList[index].item.target;
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ModifyFinancialItemScreen(
                                    defaultTitle: selectedTitle,
                                    defaultDescription: selectedDescription,
                                    id: selectedId!,
                                    costsNotifier: financialItemNotifier,
                                    selectedCategory: selectedFinancialItem!,
                                  ),
                                ),
                              ).then((value) {
                                if (value == true) {
                                  financialItemList.clear();
                                  getData2();
                                }
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: AppColors.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(AppStrings.modify,
                                    style: AppLightTextStyle.appModifyButton),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
    QueryBuilder<UserItem> builder = itemBox.query();
    Query<UserItem> query = builder.build();
    for (var element in query.find()) {
      if (element.category.target?.type == widget.type) {
        itemList.add(element);
      }
    }
  }

  void getData2() {
    QueryBuilder<UserFinancialItem> builder = financialItemBox.query();
    Query<UserFinancialItem> query = builder.build();

    for (var element in query.find()) {
      if (element.item.target?.type == widget.type && itemList.isNotEmpty) {
        financialItemList.add(element);
      }
    }
  }
}
