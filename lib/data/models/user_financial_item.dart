

import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_item.dart';

@Entity()
class FinancialItem {
  @Id()
  int id;

  String? amount;
  String? description;
  final item = ToOne<UserItem>();

  FinancialItem({this.id = 0, this.amount, this.description});
}