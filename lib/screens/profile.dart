import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
            width: ScreenUtil().setWidth(350),
            child: Image.asset('images/logo.png')),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ///pro pic
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: ScreenUtil().setHeight(150),
          ),
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: 'John Buckley',color: Colors.black,size: ScreenUtil().setSp(70),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
            child: CustomText(text: 'Member since February 2021',color: Colors.black,isBold: true,),
          ),
          SizedBox(height: ScreenUtil().setHeight(160),),


          ///check in
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: '45',color: Colors.black,size: ScreenUtil().setSp(150),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(text: 'Check-ins',color: Colors.black,size: ScreenUtil().setSp(50),isBold: true,),
          ),
          SizedBox(height: ScreenUtil().setHeight(70),),



          ///reviews
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: '12',color: Colors.black,size: ScreenUtil().setSp(150),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(text: 'Reviews',color: Colors.black,size: ScreenUtil().setSp(50),isBold: true,),
          ),
          SizedBox(height: ScreenUtil().setHeight(70),),

          ///favourite
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: '3',color: Colors.black,size: ScreenUtil().setSp(150),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(text: 'Favourites',color: Colors.black,size: ScreenUtil().setSp(50),isBold: true,),
          ),


        ],
      ),
    );
  }
}
