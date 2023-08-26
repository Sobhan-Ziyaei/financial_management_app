

import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_category.dart';
import 'package:work_report_app/data/models/user_financial_item.dart';

@Entity()
class UserItem {
  @Id()
  int id ;

  String? type;

  String? title;
  String? description;
  final category = ToOne<UserCategory>();
  final financialItem = ToMany<UserFinancialItem>();

  UserItem({this.id = 0,this.type, this.title, this.description});
}