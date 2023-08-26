import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/objectbox.g.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/screens/modify_item_screen.dart';
import 'package:work_report_app/ui/screens/item_screen.dart';
import 'package:work_report_app/ui/widgets/app_card_item2.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/buttons/app_large_black_button.dart';

class CostScreen extends StatefulWidget {
  CostScreen({Key? key}) : super(key: key);

  @override
  State<CostScreen> createState() => _CostScreenState();
}

class _CostScreenState extends State<CostScreen> {
  final itemBox = objectBox.store.box<UserItem>();
  UserCategory? selectedCategory;
  String selectedTitle = '';
  String selectedDescription = '';
  int? selectedId;
  final itemNotifier = ValueNotifier([]);
  List<UserItem> itemList = [];
  @override
  void initState() {
    getData();
    itemNotifier.value = itemList;
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
          title: AppStrings.costs,
          size: size),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              AppLargeBlackButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemScreen(
                            type: AppStrings.cost, itemNotifier: itemNotifier),
                      ),
                    ).then((value) {
                      if (value == true) {
                        itemList.clear();
                        getData();
                      }
                    });
                  },
                  text: AppStrings.registerNewCost),
              const SizedBox(height: 30),
              const Text(AppStrings.costList,
                  style: AppLightTextStyle.appMainTitle),
              SizedBox(
                height: 1000,
                child: ValueListenableBuilder(
                  valueListenable: itemNotifier,
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            itemBox.remove(itemList[index].id);
                          },
                          child: AppCardItem2(
                            category:
                                '${itemList[index].category.target?.title}',
                            title: '${itemList[index].title}',
                            description: '${itemList[index].description}',
                            modify: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedId = itemList[index].id;
                                  selectedTitle =
                                      itemBox.get(selectedId!)!.title!;
                                  selectedDescription =
                                      itemBox.get(selectedId!)!.description!;
                                  selectedCategory =
                                      itemList[index].category.target!;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ModifyItemScreen(
                                        selectedCategory: selectedCategory!,
                                        costsNotifier: itemNotifier,
                                        defaultTitle: selectedTitle,
                                        defaultDescription: selectedDescription,
                                        id: selectedId!),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    itemList.clear();
                                    getData();
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getData() {
    QueryBuilder<UserItem> builder = itemBox.query();
    Query<UserItem> query = builder.build();
    for (var element in query.find()) {
      if (element.category.target?.type == AppStrings.cost) {
        itemList.add(element);
      }
    }
  }
}
