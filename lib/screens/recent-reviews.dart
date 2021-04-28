import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';

class RecentReviews extends StatefulWidget {
  @override
  _RecentReviewsState createState() => _RecentReviewsState();
}

class _RecentReviewsState extends State<RecentReviews> {
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
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///name
                        RichText(
                          text: TextSpan(
                            text: 'John B. visited ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(55)
                            ),
                            children: [
                              TextSpan(
                                text: 'Village Cafe',
                                style: TextStyle(
                                  color: Color(0xff3800D3),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  print("Village cafe tapped!");
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
                                  ),
                                  SizedBox(height: ScreenUtil().setWidth(20),),

                                  ///name
                                  CustomText(
                                    text: 'John B.',
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
                                      '"Lorem ipsum, or lipsumas it is sometimes known, is dummy text used in laying out print, graphic or web designs."',
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
                                          rating: 4,
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///name
                        RichText(
                          text: TextSpan(
                            text: 'John B. visited ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(55)
                            ),
                            children: [
                              TextSpan(
                                text: 'Village Cafe',
                                style: TextStyle(
                                  color: Color(0xff3800D3),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  print("Village cafe tapped!");
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
                                  ),
                                  SizedBox(height: ScreenUtil().setWidth(20),),

                                  ///name
                                  CustomText(
                                    text: 'John B.',
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
                                      '"Lorem ipsum, or lipsumas it is sometimes known, is dummy text used in laying out print, graphic or web designs."',
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
                                          rating: 4,
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///name
                        RichText(
                          text: TextSpan(
                            text: 'John B. visited ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(55)
                            ),
                            children: [
                              TextSpan(
                                text: 'Village Cafe',
                                style: TextStyle(
                                  color: Color(0xff3800D3),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  print("Village cafe tapped!");
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
                                  ),
                                  SizedBox(height: ScreenUtil().setWidth(20),),

                                  ///name
                                  CustomText(
                                    text: 'John B.',
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
                                      '"Lorem ipsum, or lipsumas it is sometimes known, is dummy text used in laying out print, graphic or web designs."',
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
                                          rating: 4,
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///name
                        RichText(
                          text: TextSpan(
                            text: 'John B. visited ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(55)
                            ),
                            children: [
                              TextSpan(
                                text: 'Village Cafe',
                                style: TextStyle(
                                  color: Color(0xff3800D3),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  print("Village cafe tapped!");
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
                                  ),
                                  SizedBox(height: ScreenUtil().setWidth(20),),

                                  ///name
                                  CustomText(
                                    text: 'John B.',
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
                                      '"Lorem ipsum, or lipsumas it is sometimes known, is dummy text used in laying out print, graphic or web designs."',
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
                                          rating: 4,
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
