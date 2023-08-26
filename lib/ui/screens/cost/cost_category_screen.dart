import 'package:flutter/material.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/data/models/user_item.dart';
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

class CostCategoryScreen extends StatefulWidget {
  CostCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CostCategoryScreen> createState() => _CostCategoryScreenState();
}

class _CostCategoryScreenState extends State<CostCategoryScreen> {
  final categoryBox = objectBox.store.box<UserCategory>();
  final itemBox = objectBox.store.box<UserItem>();
  String selectedTitle = '';
  String selectedDescription = '';
  int? selectedId;
  String? type ;
  final categoriesNotifier = ValueNotifier([]);
  @override
  void initState() {
    categoriesNotifier.value = categoryBox.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QueryBuilder<UserCategory> builder =
        categoryBox.query(UserCategory_.type.equals('هزینه'));
    Query<UserCategory> query = builder.build();
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppMainAppBar(
          icon: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: AppStrings.costCategory,
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
                            type: AppStrings.cost,
                            categoriesNotifier: categoriesNotifier),
                      ),
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
                      itemCount: query.find().length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              categoryBox.remove(query.find()[index].id);

                            });
                          },
                          child: AppCardItem2(
                            title: '${query.find()[index].title}',
                            description: '${query.find()[index].description}',
                            modify: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedId = query.find()[index].id;
                                  type = query.find()[index].type ;
                                  selectedTitle =
                                      categoryBox.get(selectedId!)!.title!;
                                  selectedDescription = categoryBox
                                      .get(selectedId!)!
                                      .description!;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ModifyCategoryScreen(
                                      categoriesNotifier: categoriesNotifier,
                                      defaultTitle: selectedTitle,
                                      defaultDescription: selectedDescription,
                                      id: selectedId!,
                                      type: type!,
                                    ),
                                  ),
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

}
