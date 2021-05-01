import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/screens/sign-up.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';


class Welcome extends StatelessWidget {
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
                onclick: (){},
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
                onclick: (){},
              ),
            ),


            ///bottom text
            SizedBox(height: ScreenUtil().setHeight(180),),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(40)),
              child: CustomText(
                text: "Create your free account to begin finding out what's happening in the village of Biarney and its",
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