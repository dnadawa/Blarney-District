import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/screens/individual-business.dart';
import 'package:village_app/widgets/custom-text.dart';

import 'admin/add-business.dart';

class BusinessDirectory extends StatefulWidget {
  @override
  _BusinessDirectoryState createState() => _BusinessDirectoryState();
}

class _BusinessDirectoryState extends State<BusinessDirectory> {
  List<DocumentSnapshot> businesses;
  StreamSubscription<QuerySnapshot> subscription;

  getBusinesses(){
    subscription = FirebaseFirestore.instance.collection('businesses').snapshots().listen((datasnapshot){
      setState(() {
        businesses = datasnapshot.docs;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusinesses();
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AddBusiness()),
          );
        },
      ),
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
              child: businesses!=null?ListView.builder(
                itemCount: businesses.length,
                itemBuilder: (context, i){
                  String name = businesses[i]['name'];
                  String description = businesses[i]['description'];
                  String phone = businesses[i]['phone'];
                  String address = businesses[i]['address'];
                  String facebook = businesses[i]['facebook'];
                  String twitter = businesses[i]['twitter'];
                  String instagram = businesses[i]['instagram'];
                  String image = businesses[i]['image'];
                  String rating = businesses[i]['rating'].toString();
                  int reviews = businesses[i]['reviews'];
                  double lat = businesses[i]['lat'];
                  double long = businesses[i]['long'];
                  List checkIns = businesses[i]['checkins'];
                  List favourites = businesses[i]['favourites'];
                  String id = businesses[i].id;

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => IndividualBusiness(
                          image: image,
                          phone: phone,
                          description: description,
                          address: address,
                          facebook: facebook,
                          instagram: instagram,
                          rating: rating,
                          reviews: reviews,
                          twitter: twitter,
                          lat: lat,
                          checkIns: checkIns,
                          long: long,
                          id: id,
                          favourites: favourites,
                          name: name,
                        )),
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
                            color: Colors.transparent,
                            child: FadeInImage(
                              image: NetworkImage(image),
                              placeholder: AssetImage('images/logo.png'),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(20),),

                          ///details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ///name
                                CustomText(
                                  text: name,
                                  isBold: true,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(70),
                                  align: TextAlign.start,
                                ),
                                SizedBox(height: ScreenUtil().setWidth(15),),


                                ///description
                                CustomText(
                                  text: description,
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
                                      rating: double.parse(rating),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Color(0xffD3DB11),
                                      ),
                                      itemCount: 5,
                                      itemSize: 18,
                                    ),


                                    ///rating text
                                    CustomText(
                                      text: '$rating/5.0 ($reviews Reviews)',
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
                                              text: address,
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
                                          text: phone,
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