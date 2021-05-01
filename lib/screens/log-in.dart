import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/input-field.dart';
import 'package:village_app/widgets/toast.dart';

import 'home.dart';

class LogIn extends StatefulWidget {

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  logIn() async {
    if(email.text.isNotEmpty &&password.text.isNotEmpty) {
      ToastBar(text: 'Please wait', color: Colors.orange).show();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text
        );
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) =>
                Home()), (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ToastBar(text: 'No user found for that email', color: Colors.red).show();
        } else if (e.code == 'wrong-password') {
          ToastBar(
              text: 'Password incorrect', color: Colors.red).show();
        }
      }
    }
    else{
      ToastBar(text: 'Please fill all fields',color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(ScreenUtil().setHeight(40)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Log into your account',size: ScreenUtil().setSp(80),color: Colors.black,isBold: true,),
                SizedBox(height: ScreenUtil().setHeight(60),),
                InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
                InputField(hint: 'Password',isPassword:true,controller: password,),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                  child: Button(
                    text: 'Log In',
                    color: Theme.of(context).primaryColor,
                    textColor: Color(0xffC7A92B),
                    onclick: ()=>logIn()),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}