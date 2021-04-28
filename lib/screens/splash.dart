import 'dart:async';

import 'package:flutter/material.dart';
import 'package:village_app/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
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
