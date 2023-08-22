

import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_item.dart';

@Entity()
class UserCategory {
  @Id()
  int id;

  String? type;
  String? title;
  String? description;
  final items = ToMany<UserItem>();

  UserCategory({this.id = 0, this.type, this.title, this.description});
}