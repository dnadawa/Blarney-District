import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:village_app/screens/home.dart';
import 'package:village_app/screens/welcome.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  _initFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initFirebase();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              Welcome()), (Route<dynamic> route) => false);
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
