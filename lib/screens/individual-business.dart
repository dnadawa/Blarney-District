import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/icon-text-button.dart';

class IndividualBusiness extends StatefulWidget {
  @override
  _IndividualBusinessState createState() => _IndividualBusinessState();
}

class _IndividualBusinessState extends State<IndividualBusiness> {
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
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///image
              Container(
                color: Colors.blue,
                height: ScreenUtil().setHeight(500),
              ),
              SizedBox(height: ScreenUtil().setWidth(30),),

              ///description
              CustomText(
                text: 'Award wining cafe located near the village square. Coffee/Tea, Sandwiches and more',
                isBold: true,
                color: Colors.black,
                size: ScreenUtil().setSp(40),
                align: TextAlign.start,
              ),
              SizedBox(height: ScreenUtil().setWidth(40),),


              ///contacts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ///phone
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.phone,color: Color(0xff0B8A28),size: 20,),
                      SizedBox(width: ScreenUtil().setWidth(20),),
                      CustomText(
                        text: '021 438 1111',
                        color: Color(0xff0B8A28),
                        size: ScreenUtil().setSp(50),
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      ///facebook
                      SizedBox(
                        width: ScreenUtil().setHeight(80),
                        height: ScreenUtil().setHeight(80),
                        child: Image.asset('images/facebook.png'),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(20),),

                      ///twitter
                      SizedBox(
                        width: ScreenUtil().setHeight(80),
                        height: ScreenUtil().setHeight(80),
                        child: Image.asset('images/twitter.png'),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(20),),

                      ///instagram
                      SizedBox(
                        width: ScreenUtil().setHeight(80),
                        height: ScreenUtil().setHeight(80),
                        child: Image.asset('images/insta.png'),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(20),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(60),),

              ///buttons
              Row(
                children: [

                  ///check in
                  Expanded(
                    child: IconTextButton(
                      color: Color(0xff0B8A28),
                      text: 'Check In',
                      icon: Icons.check,
                      onTap: (){},
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(15),),

                  ///review
                  Expanded(
                    child: IconTextButton(
                      color: Color(0xff3800D3),
                      text: 'Leave a Review',
                      icon: Icons.rate_review,
                      onTap: (){},
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(15),),

                  ///favourite
                  Expanded(
                    child: IconTextButton(
                      color: Color(0xffC7A92B),
                      text: 'Add to Favourites',
                      icon: Icons.favorite,
                      onTap: (){},
                    ),
                  ),

                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(60),),

              ///address
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.room,color: Color(0xff3800D3),size: 20,),
                  SizedBox(width: ScreenUtil().setWidth(20),),
                  CustomText(
                    text: 'Kiln Road',
                    color: Color(0xff3800D3),
                    size: ScreenUtil().setSp(50),
                    align: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(30),),

              ///map
              Container(
                height: ScreenUtil().setHeight(350),
                color: Colors.green,
              ),
              SizedBox(height: ScreenUtil().setWidth(40),),

              ///rating
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  ///rating
                  CustomText(
                    text: 'Rating',
                    isBold: true,
                    color: Colors.black,
                    size: ScreenUtil().setSp(40),
                    align: TextAlign.start,
                  ),
                  SizedBox(width: ScreenUtil().setWidth(50),),

                  ///stars
                  RatingBarIndicator(
                    rating: 4,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Color(0xffD3DB11),
                    ),
                    itemCount: 5,
                    itemSize: 30,
                  ),
                  SizedBox(width: ScreenUtil().setWidth(30),),


                  ///rating text
                  CustomText(
                    text: '4.5/5.0\n(10 Reviews)',
                    color: Colors.black,
                    size: ScreenUtil().setSp(35),
                    align: TextAlign.start,
                  ),

                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(40),),


              ///recent reviews
              CustomText(
                text: 'Recent Reviews',
                isBold: true,
                color: Colors.black,
                size: ScreenUtil().setSp(40),
                align: TextAlign.start,
              ),
              SizedBox(height: ScreenUtil().setWidth(20),),


              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),0,ScreenUtil().setWidth(20),ScreenUtil().setWidth(30)),
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),0,ScreenUtil().setWidth(20),ScreenUtil().setWidth(30)),
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),0,ScreenUtil().setWidth(20),ScreenUtil().setWidth(30)),
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


            ],
          ),
        ),
      ),
    );
  }
}
