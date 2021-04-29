import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/screens/individual-business.dart';
import 'package:village_app/widgets/custom-text.dart';

class BusinessDirectory extends StatefulWidget {
  @override
  _BusinessDirectoryState createState() => _BusinessDirectoryState();
}

class _BusinessDirectoryState extends State<BusinessDirectory> {
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
              text: 'Business Directory',
              size: ScreenUtil().setSp(100),
              color: Colors.black,
            ),
          ),

          Expanded(
            child: Padding(
              padding:  EdgeInsets.all(ScreenUtil().setHeight(25)),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => IndividualBusiness()),
                      );
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///picture
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.width/3,
                            color: Colors.blue,
                          ),
                          SizedBox(width: ScreenUtil().setWidth(20),),

                          ///details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ///name
                                CustomText(
                                  text: 'Village Cafe',
                                  isBold: true,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(70),
                                  align: TextAlign.start,
                                ),
                                SizedBox(height: ScreenUtil().setWidth(15),),


                                ///description
                                CustomText(
                                  text: 'Award wining cafe located near the village square. Coffee/Tea, Sandwiches and more',
                                  isBold: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  size: ScreenUtil().setSp(40),
                                  align: TextAlign.start,
                                ),
                                SizedBox(height: ScreenUtil().setWidth(15),),

                                ///rating
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    ///stars
                                    RatingBarIndicator(
                                      rating: 4,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Color(0xffD3DB11),
                                      ),
                                      itemCount: 5,
                                      itemSize: 18,
                                    ),


                                    ///rating text
                                    CustomText(
                                      text: '4.5/5.0 (10 Reviews)',
                                      color: Colors.black,
                                      size: ScreenUtil().setSp(35),
                                      align: TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(height: ScreenUtil().setWidth(5),),

                                ///contact
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    ///location
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.room,color: Color(0xff3800D3),size: 18,),
                                          SizedBox(width: ScreenUtil().setWidth(5),),
                                          Expanded(
                                            child: CustomText(
                                              text: 'Klin Road',
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff3800D3),
                                              size: ScreenUtil().setSp(35),
                                              align: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///phone
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.phone,color: Color(0xff0B8A28),size: 18,),
                                        SizedBox(width: ScreenUtil().setWidth(5),),
                                        CustomText(
                                          text: '021 438 1111',
                                          color: Color(0xff0B8A28),
                                          size: ScreenUtil().setSp(35),
                                          align: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///picture
                        Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.width/3,
                          color: Colors.blue,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20),),

                        ///details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///name
                              CustomText(
                                text: 'Village Cafe',
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: ScreenUtil().setSp(70),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),


                              ///description
                              CustomText(
                                text: 'Award wining cafe located near the village square. Coffee/Tea, Sandwiches and more',
                                isBold: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                size: ScreenUtil().setSp(40),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),

                              ///rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///stars
                                  RatingBarIndicator(
                                    rating: 4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Color(0xffD3DB11),
                                    ),
                                    itemCount: 5,
                                    itemSize: 18,
                                  ),


                                  ///rating text
                                  CustomText(
                                    text: '4.5/5.0 (10 Reviews)',
                                    color: Colors.black,
                                    size: ScreenUtil().setSp(35),
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setWidth(5),),

                              ///contact
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///location
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.room,color: Color(0xff3800D3),size: 18,),
                                        SizedBox(width: ScreenUtil().setWidth(5),),
                                        Expanded(
                                          child: CustomText(
                                            text: 'Klin Road',
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(0xff3800D3),
                                            size: ScreenUtil().setSp(35),
                                            align: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///phone
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.phone,color: Color(0xff0B8A28),size: 18,),
                                      SizedBox(width: ScreenUtil().setWidth(5),),
                                      CustomText(
                                        text: '021 438 1111',
                                        color: Color(0xff0B8A28),
                                        size: ScreenUtil().setSp(35),
                                        align: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///picture
                        Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.width/3,
                          color: Colors.blue,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20),),

                        ///details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///name
                              CustomText(
                                text: 'Village Cafe',
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: ScreenUtil().setSp(70),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),


                              ///description
                              CustomText(
                                text: 'Award wining cafe located near the village square. Coffee/Tea, Sandwiches and more',
                                isBold: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                size: ScreenUtil().setSp(40),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),

                              ///rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///stars
                                  RatingBarIndicator(
                                    rating: 4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Color(0xffD3DB11),
                                    ),
                                    itemCount: 5,
                                    itemSize: 18,
                                  ),


                                  ///rating text
                                  CustomText(
                                    text: '4.5/5.0 (10 Reviews)',
                                    color: Colors.black,
                                    size: ScreenUtil().setSp(35),
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setWidth(5),),

                              ///contact
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///location
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.room,color: Color(0xff3800D3),size: 18,),
                                        SizedBox(width: ScreenUtil().setWidth(5),),
                                        Expanded(
                                          child: CustomText(
                                            text: 'Klin Road',
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(0xff3800D3),
                                            size: ScreenUtil().setSp(35),
                                            align: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///phone
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.phone,color: Color(0xff0B8A28),size: 18,),
                                      SizedBox(width: ScreenUtil().setWidth(5),),
                                      CustomText(
                                        text: '021 438 1111',
                                        color: Color(0xff0B8A28),
                                        size: ScreenUtil().setSp(35),
                                        align: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///picture
                        Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.width/3,
                          color: Colors.blue,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20),),

                        ///details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///name
                              CustomText(
                                text: 'Village Cafe',
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: ScreenUtil().setSp(70),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),


                              ///description
                              CustomText(
                                text: 'Award wining cafe located near the village square. Coffee/Tea, Sandwiches and more',
                                isBold: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                size: ScreenUtil().setSp(40),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),

                              ///rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///stars
                                  RatingBarIndicator(
                                    rating: 4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Color(0xffD3DB11),
                                    ),
                                    itemCount: 5,
                                    itemSize: 18,
                                  ),


                                  ///rating text
                                  CustomText(
                                    text: '4.5/5.0 (10 Reviews)',
                                    color: Colors.black,
                                    size: ScreenUtil().setSp(35),
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setWidth(5),),

                              ///contact
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///location
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.room,color: Color(0xff3800D3),size: 18,),
                                        SizedBox(width: ScreenUtil().setWidth(5),),
                                        Expanded(
                                          child: CustomText(
                                            text: 'Klin Road',
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(0xff3800D3),
                                            size: ScreenUtil().setSp(35),
                                            align: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///phone
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.phone,color: Color(0xff0B8A28),size: 18,),
                                      SizedBox(width: ScreenUtil().setWidth(5),),
                                      CustomText(
                                        text: '021 438 1111',
                                        color: Color(0xff0B8A28),
                                        size: ScreenUtil().setSp(35),
                                        align: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///picture
                        Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.width/3,
                          color: Colors.blue,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20),),

                        ///details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///name
                              CustomText(
                                text: 'Village Cafe',
                                isBold: true,
                                color: Theme.of(context).primaryColor,
                                size: ScreenUtil().setSp(70),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),


                              ///description
                              CustomText(
                                text: 'Award wining cafe located near the village square. Coffee/Tea, Sandwiches and more',
                                isBold: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                size: ScreenUtil().setSp(40),
                                align: TextAlign.start,
                              ),
                              SizedBox(height: ScreenUtil().setWidth(15),),

                              ///rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///stars
                                  RatingBarIndicator(
                                    rating: 4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Color(0xffD3DB11),
                                    ),
                                    itemCount: 5,
                                    itemSize: 18,
                                  ),


                                  ///rating text
                                  CustomText(
                                    text: '4.5/5.0 (10 Reviews)',
                                    color: Colors.black,
                                    size: ScreenUtil().setSp(35),
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setWidth(5),),

                              ///contact
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///location
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.room,color: Color(0xff3800D3),size: 18,),
                                        SizedBox(width: ScreenUtil().setWidth(5),),
                                        Expanded(
                                          child: CustomText(
                                            text: 'Klin Road',
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(0xff3800D3),
                                            size: ScreenUtil().setSp(35),
                                            align: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///phone
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.phone,color: Color(0xff0B8A28),size: 18,),
                                      SizedBox(width: ScreenUtil().setWidth(5),),
                                      CustomText(
                                        text: '021 438 1111',
                                        color: Color(0xff0B8A28),
                                        size: ScreenUtil().setSp(35),
                                        align: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
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