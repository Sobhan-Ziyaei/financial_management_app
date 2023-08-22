import 'package:flutter/material.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';

class AppMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget icon;
  final String title;
  final Size size;
  AppMainAppBar({required this.icon, required this.title, required this.size});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(size.width, size.height * 0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            icon,
            const Spacer(),
            Text(title, style: AppLightTextStyle.appMainTitle),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size.height * 0.1);
}
