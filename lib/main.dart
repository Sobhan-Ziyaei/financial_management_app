import 'package:flutter/material.dart';
import 'package:work_report_app/data/object_box.dart';
import 'package:work_report_app/route/names.dart';
import 'package:work_report_app/route/routes.dart';

late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenNames.root,
      routes: routes,
    );
  }
}





