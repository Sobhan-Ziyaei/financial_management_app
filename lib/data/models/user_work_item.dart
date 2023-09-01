import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_item.dart';

@Entity()
class UserWorkItem {
  @Id()
  int id;

  DateTime? begin;
  DateTime? end;
  String? description;
  final item = ToOne<UserItem>();

  UserWorkItem({this.id = 0, this.begin, this.end, this.description});
}
