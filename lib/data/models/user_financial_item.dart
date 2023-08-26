import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_item.dart';

@Entity()
class UserFinancialItem {
  @Id()
  int id;

  String? amount;
  String? description;
  final item = ToOne<UserItem>();

  UserFinancialItem({this.id = 0, this.amount, this.description});
}
