import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/data/models/user_item.dart';
import 'package:work_report_app/main.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';
import 'package:work_report_app/ui/widgets/app_main_app_bar.dart';
import 'package:work_report_app/ui/widgets/app_main_text_field.dart';
import 'package:work_report_app/ui/widgets/buttons/app_green_button.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({Key? key, required this.type, required this.itemNotifier})
      : super(key: key);
  String? type;
  final ValueNotifier itemNotifier;
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final categoryBox = objectBox.store.box<UserCategory>();
  final itemBox = objectBox.store.box<UserItem>();
  UserCategory? selectedCategory;
  final List<UserCategory> titleList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    addTitleList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppMainAppBar(
          icon: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: AppStrings.registerNewItem,
          size: size),
      backgroundColor: AppColors.mainBackground,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.type!,
                  style: AppLightTextStyle.appMainTitle,
                ),
                const SizedBox(height: 50),
                DropdownButtonFormField<UserCategory>(
                  value: selectedCategory,
                  onChanged: (value) {
                    print(value?.id.toString());
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  items: titleList.map((cat) {
                    return DropdownMenuItem<UserCategory>(
                      value: cat,
                      child: Text(cat.title!),
                    );
                  }).toList(),
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
                      addItem(widget.type!, titleController.text,
                          descriptionController.text);
                    },
                    text: AppStrings.save)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addTitleList() {
    QueryBuilder<UserCategory> builder = categoryBox.query();
    Query<UserCategory> query = builder.build();
    for (var element in query.find()) {
      if (element.type == widget.type) {
        titleList.add(element);
      }
    }
  }

  void addItem(String type, String title, String description) {
    var item = UserItem(type: type, title: title, description: description);
    item.category.target = selectedCategory;
    itemBox.put(item);
    widget.itemNotifier.value = itemBox.getAll();
    Navigator.pop(context, true);
  }

  
}
