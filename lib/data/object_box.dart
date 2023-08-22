
import 'package:path/path.dart' as p;
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:work_report_app/objectbox.g.dart';

class ObjectBox {
  final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    var dir = await getApplicationDocumentsDirectory();
    Store store =
        await openStore(directory: p.join(dir.path, 'objectbox_financialManagement'));

    return ObjectBox._create(store);
  }
}