import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';

class SpecialOffers extends StatefulWidget {
  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
            child: CustomText(
              text: 'Special Offers',
              size: ScreenUtil().setSp(100),
              color: Colors.black,
            ),
          ),

          Expanded(
            child: Padding(
              padding:  EdgeInsets.all(ScreenUtil().setHeight(25)),
              child: ListView(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                      child: Container(
                        color: Colors.red,
                        height: ScreenUtil().setHeight(600),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                      child: Container(
                        color: Colors.red,
                        height: ScreenUtil().setHeight(600),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                      child: Container(
                        color: Colors.red,
                        height: ScreenUtil().setHeight(600),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                      child: Container(
                        color: Colors.red,
                        height: ScreenUtil().setHeight(600),
                      ),
                    ),


                  ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
