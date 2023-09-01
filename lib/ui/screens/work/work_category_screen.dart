import 'package:flutter/material.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/objectbox.g.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/screens/modify_category_screen.dart';
import 'package:work_report_app/ui/screens/register_category_screen.dart';
import 'package:work_report_app/ui/widgets/buttons/app_large_black_button.dart';
import 'package:work_report_app/ui/widgets/app_card_item2.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';

class WorkCategoryScreen extends StatefulWidget {
  WorkCategoryScreen({Key? key}) : super(key: key);

  @override
  State<WorkCategoryScreen> createState() => _WorkCategoryScreenState();
}

class _WorkCategoryScreenState extends State<WorkCategoryScreen> {
  final categoryBox = objectBox.store.box<UserCategory>();
  String selectedTitle = '';
  String selectedDescription = '';
  int? selectedId;
  String? type;
  List<UserCategory> itemList = [];
  final categoriesNotifier = ValueNotifier([]);
  @override
  void initState() {
    categoriesNotifier.value = categoryBox.getAll();
    getData();
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
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: AppStrings.workCategory,
          size: size),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              AppLargeBlackButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterCategoryScreen(
                          type: AppStrings.work,
                          categoriesNotifier: categoriesNotifier,
                        ),
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          itemList.clear();
                          getData();
                        }
                      },
                    );
                  },
                  text: AppStrings.registerNewCategory),
              const SizedBox(height: 50),
              const Text(AppStrings.categoryList,
                  style: AppLightTextStyle.appMainTitle),
              SizedBox(
                height: 1000,
                child: ValueListenableBuilder(
                  valueListenable: categoriesNotifier,
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            categoryBox.remove(itemList[index].id);
                          },
                          child: AppCardItem2(
                            title: '${itemList[index].title}',
                            description: '${itemList[index].description}',
                            modify: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedId = itemList[index].id;
                                  selectedTitle =
                                      categoryBox.get(selectedId!)!.title!;
                                  type = itemList[index].type;
                                  selectedDescription = categoryBox
                                      .get(selectedId!)!
                                      .description!;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ModifyCategoryScreen(
                                        type: type!,
                                        categoriesNotifier: categoriesNotifier,
                                        defaultTitle: selectedTitle,
                                        defaultDescription: selectedDescription,
                                        id: selectedId!),
                                  ),
                                ).then(
                                  (value) {
                                    if (value == true) {
                                      itemList.clear();
                                      getData();
                                    }
                                  },
                                );
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

  void getData() {
    QueryBuilder<UserCategory> builder =
        categoryBox.query(UserCategory_.type.equals(AppStrings.work));
    Query<UserCategory> query = builder.build();
    for (var element in query.find()) {
      itemList.add(element);
    }
  }
}
