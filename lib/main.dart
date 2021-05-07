import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/screens/splash.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 2340),
      builder: () => MaterialApp(
        home: Splash(),
        theme: ThemeData(
            primaryColor: Color(0xff530406),
            accentColor: Colors.white
        ),
      ),
    );
  }
}