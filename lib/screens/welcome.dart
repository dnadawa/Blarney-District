import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/screens/log-in.dart';
import 'package:village_app/screens/sign-up.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/toast.dart';

import 'home.dart';


class Welcome extends StatelessWidget {

  signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email'],loginBehavior: LoginBehavior.WEB_ONLY);
    if(result.status == LoginStatus.success){

      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);

      var x = await FirebaseAuth.instance.signInWithCredential(credential);
      print(x.user);

      var sub = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: x.user.email).get();
      var user = sub.docs;
      if(user.isEmpty){
        await FirebaseFirestore.instance.collection('users').doc(x.user.email).set({
          'fname': x.user.displayName.split(" ")[0],
          'lname': x.user.displayName.split(" ")[1],
          'image': x.user.photoURL,
          'email': x.user.email,
          'joined': DateTime.now().toString()
        });
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', x.user.email);
      prefs.setString('name', x.user.displayName.split(" ")[0]+" "+x.user.displayName.split(" ")[1][0]+".");
      prefs.setString('image', x.user.photoURL);

      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) =>
              Home()), (Route<dynamic> route) => false);

    }
    else{
      ToastBar(text: 'Something went wrong! Error code: ${result.status}',color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.png'),
            fit: BoxFit.fitHeight,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ///logo
            Container(
                width: ScreenUtil().setHeight(600),
                child: Image.asset('images/logo.png')),
            SizedBox(height: ScreenUtil().setHeight(400),),


            ///log in
            SizedBox(
              width: ScreenUtil().setWidth(500),
              child: Button(
                text: 'Log in',
                color: Theme.of(context).primaryColor,
                textColor: Color(0xffC7A92B),
                onclick: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => LogIn()),
                  );
                },
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20),),

            ///sign up
            SizedBox(
              width: ScreenUtil().setWidth(500),
              child: Button(
                text: 'Sign up',
                color: Theme.of(context).primaryColor,
                textColor: Color(0xffC7A92B),
                onclick: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => SignUp()),
                  );
                },
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20),),

            ///facebook login
            SizedBox(
              width: ScreenUtil().setWidth(500),
              child: Button(
                text: 'Facebook Login',
                color: Color(0xff040453),
                onclick: ()=>signInWithFacebook(context),
              ),
            ),


            ///bottom text
            SizedBox(height: ScreenUtil().setHeight(180),),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(40)),
              child: CustomText(
                text: "Create your free account to begin finding out what's happening in the village of Blarney and its surroundings",
                color: Colors.black,
                size: ScreenUtil().setSp(60),
              ),
            )



          ],
        ),
      ),
    );
  }
}