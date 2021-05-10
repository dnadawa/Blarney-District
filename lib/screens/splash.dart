import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/screens/admin/admin-home.dart';
import 'package:village_app/screens/home.dart';
import 'package:village_app/screens/welcome.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  _initFirebase() async {
    await Firebase.initializeApp();
    await DotEnv.load(fileName: ".env");
    OneSignal.shared.init(
        env['ONESIGNAL_ID'],
        iOSSettings: {
          OSiOSSettings.autoPrompt: true,
          OSiOSSettings.inAppLaunchUrl: true
        });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initFirebase();
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      bool isAdmin = prefs.getBool('isAdmin') ?? false;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              email==null?Welcome():isAdmin?AdminHome():Home()), (Route<dynamic> route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: Image.asset('images/logo.png'),
            )
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: Image.asset('images/splash.png',fit: BoxFit.cover,),
            )
          ),
        ],
      ),
    );
  }
}
