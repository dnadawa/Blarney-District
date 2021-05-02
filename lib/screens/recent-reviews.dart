import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';

import 'individual-business.dart';

class RecentReviews extends StatefulWidget {
  @override
  _RecentReviewsState createState() => _RecentReviewsState();
}

class _RecentReviewsState extends State<RecentReviews> {
  List<DocumentSnapshot> reviews;
  StreamSubscription<QuerySnapshot> subscription;

  getReviews(){
    subscription = FirebaseFirestore.instance.collection('reviews').snapshots().listen((datasnapshot){
      setState(() {
        reviews = datasnapshot.docs;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviews();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

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
              text: 'Recent Reviews',
              size: ScreenUtil().setSp(100),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
              child: reviews!=null?ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, i){
                  String review = reviews[i]['review'];
                  String rating = reviews[i]['rating'].toString();
                  String authorName = reviews[i]['author'];
                  String authorImage = reviews[i]['authorImage'];
                  String businessName = reviews[i]['businessName'];
                  String businessId = reviews[i]['businessId'];

                  return Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///name
                        RichText(
                          text: TextSpan(
                            text: '$authorName visited ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(55)
                            ),
                            children: [
                              TextSpan(
                                  text: businessName,
                                  style: TextStyle(
                                      color: Color(0xff3800D3),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    print(businessId);
                                    FirebaseFirestore.instance.collection("businesses").doc(businessId).get().then((value){
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(builder: (context) => IndividualBusiness(
                                          image: value.get('image'),
                                          phone: value.get('phone'),
                                          description: value.get('description'),
                                          address: value.get('address'),
                                          facebook: value.get('facebook'),
                                          instagram: value.get('instagram'),
                                          rating: value.get('rating').toString(),
                                          reviews: value.get('reviews'),
                                          twitter: value.get('twitter'),
                                          lat: value.get('lat'),
                                          checkIns: value.get('checkins'),
                                          long: value.get('long'),
                                          id: businessId,
                                          favourites: value.get('favourites'),
                                          name: value.get('name'),
                                        )),
                                      );

                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setWidth(20),),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///person
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ///pro pic
                                  CircleAvatar(
                                    radius: ScreenUtil().setWidth(70),
                                    backgroundImage: NetworkImage(authorImage),
                                  ),
                                  SizedBox(height: ScreenUtil().setWidth(20),),

                                  ///name
                                  CustomText(
                                    text: authorName,
                                    isBold: true,
                                    color: Colors.black,
                                    size: ScreenUtil().setSp(45),
                                  ),
                                ],
                              ),
                              SizedBox(width: ScreenUtil().setWidth(20),),

                              ///review
                              Expanded(
                                child: Column(
                                  children: [

                                    ///text review
                                    Text(
                                      '"$review"',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                          fontSize: ScreenUtil().setSp(45)
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(height: ScreenUtil().setWidth(10),),

                                    ///stars
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: ScreenUtil().setWidth(60)),
                                        child: RatingBarIndicator(
                                          rating: double.parse(rating),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Color(0xffD3DB11),
                                          ),
                                          itemCount: 5,
                                          itemSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ):Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),),
            ),
          )
        ],
      ),
    );
  }
}
