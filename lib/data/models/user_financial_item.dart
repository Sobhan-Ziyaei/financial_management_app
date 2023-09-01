import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_item.dart';

@Entity()
class UserFinancialItem {
  @Id()
  int id;

  String? amount;
  String? description;
  DateTime? date;
  
  final item = ToOne<UserItem>();

  String? year;
  String? month;
  String? day;

  UserFinancialItem(
      {this.id = 0,
      this.amount,
      this.description,
      this.date,
      this.year,
      this.month,
      this.day,
      });
}
