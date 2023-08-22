

import 'package:objectbox/objectbox.dart';
import 'package:work_report_app/data/models/user_category.dart';

@Entity()
class UserItem {
  @Id()
  int id = 0;

  String? type;

  String? title;
  String? description;
  final category = ToOne<UserCategory>();

  UserItem({this.type, this.title, this.description});
}