import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:work_report_app/route/names.dart';
import 'package:work_report_app/ui/components/app_text_style.dart';
import 'package:work_report_app/ui/constants/app_colors.dart';
import 'package:work_report_app/ui/constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.splashScreenText,
                style: AppLightTextStyle.appSplashScreenLogo,
              ),
              SizedBox(
                height: 15,
              ),
              SpinKitChasingDots(
                color: AppColors.black,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigate() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, ScreenNames.homeScreen);
    });
  }
}
