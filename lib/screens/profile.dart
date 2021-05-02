import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/widgets/custom-text.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  

  String name="";
  String image="";
  int checkIns = 0;
  int reviewsCount = 0;
  int favourites = 0;
  var joined;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    var user = sub.docs;

    setState(() {
      name = user[0]['fname']+" "+user[0]['lname'];
      image = user[0]['image'];
      joined = DateFormat('MMMM yyyy').format(DateTime.parse(user[0]['joined']));
    });
  }

  getCheckins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance.collection('businesses').where('checkins', arrayContains: email).get();
    var business = sub.docs;

    setState(() {
      checkIns = business.length;
    });
  }

  getFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance.collection('businesses').where('favourites', arrayContains: email).get();
    var business = sub.docs;

    setState(() {
      favourites = business.length;
    });
  }

  getReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance.collection('reviews').where('authorEmail', isEqualTo: email).get();
    var reviews = sub.docs;

    setState(() {
      reviewsCount = reviews.length;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getCheckins();
    getFavourites();
    getReviews();
  }
  
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
            backgroundColor: Colors.transparent,
            radius: ScreenUtil().setHeight(150),
           child: ClipOval(
             child: FadeInImage(placeholder: AssetImage('images/avatar.png'), image: NetworkImage(image),fit: BoxFit.cover,height: ScreenUtil().setHeight(300),width: ScreenUtil().setHeight(300),),
           ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: name,color: Colors.black,size: ScreenUtil().setSp(70),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
            child: CustomText(text: 'Member since $joined',color: Colors.black,isBold: true,),
          ),
          SizedBox(height: ScreenUtil().setHeight(160),),


          ///check in
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: checkIns.toString(),color: Colors.black,size: ScreenUtil().setSp(150),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(text: 'Check-ins',color: Colors.black,size: ScreenUtil().setSp(50),isBold: true,),
          ),
          SizedBox(height: ScreenUtil().setHeight(70),),



          ///reviews
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: reviewsCount.toString(),color: Colors.black,size: ScreenUtil().setSp(150),isBold: true,),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(text: 'Reviews',color: Colors.black,size: ScreenUtil().setSp(50),isBold: true,),
          ),
          SizedBox(height: ScreenUtil().setHeight(70),),

          ///favourite
          Padding(
            padding:  EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(text: favourites.toString(),color: Colors.black,size: ScreenUtil().setSp(150),isBold: true,),
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
