import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/screens/individual-business.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/toast.dart';
import 'package:http/http.dart' as http;

import 'admin/add-business.dart';

class BusinessDirectory extends StatefulWidget {
  @override
  _BusinessDirectoryState createState() => _BusinessDirectoryState();
}

class _BusinessDirectoryState extends State<BusinessDirectory> {
  List<DocumentSnapshot> businesses;
  StreamSubscription<QuerySnapshot> subscription;
  bool isAdmin = false;
  getBusinesses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool('isAdmin') ?? false;
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
      floatingActionButton: isAdmin?FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AddBusiness()),
          );
        },
      ):null,
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

                  return Column(
                    children: [
                      GestureDetector(
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
                      ),


                      ///buttons
                      if(isAdmin)
                        Padding(
                          padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(35)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ///edit button
                              GestureDetector(
                                onTap: () async {
                                  ToastBar(text: 'Please wait...',color: Colors.orange).show();
                                  var response = await http.get(Uri.parse(image));
                                  var dir = await getTemporaryDirectory();
                                  File imageFile = File(dir.path+'/${DateTime.now().millisecondsSinceEpoch.toString()}.png');
                                  imageFile.writeAsBytesSync(response.bodyBytes);

                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) => AddBusiness(
                                      id: id,
                                      image: imageFile,
                                      description: description,
                                      name: name,
                                      long: long,
                                      lat: lat,
                                      twitter: twitter,
                                      reviews: reviews,
                                      rating: rating,
                                      instagram: instagram,
                                      facebook: facebook,
                                      address: address,
                                      phone: phone,
                                      checkins: checkIns,
                                      favourites: favourites,
                                    )),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.edit,color: Colors.green,),
                                ),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(15),),

                              ///delete button
                              GestureDetector(
                                onTap: () async {
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context){
                                  //       return AlertDialog(
                                  //         content: CustomText(text: 'Are you sure you want to remove this offer?',color: Colors.black,),
                                  //         actions: [
                                  //           TextButton(
                                  //             child: CustomText(text: 'Yes',color: Colors.black,isBold: true,size: ScreenUtil().setSp(35),),
                                  //             onPressed:  () async {
                                  //               try{
                                  //                 await FirebaseFirestore.instance.collection('offers').doc(offers[i].id).delete();
                                  //                 ToastBar(text: 'Offer Removed!',color: Colors.green).show();
                                  //                 Navigator.pop(context);
                                  //               }
                                  //               catch(e){
                                  //                 ToastBar(text: 'Something went wrong',color: Colors.red).show();
                                  //               }
                                  //             },
                                  //           ),
                                  //           TextButton(
                                  //             child: CustomText(text: 'No',color: Colors.black, isBold: true, size: ScreenUtil().setSp(35),),
                                  //             onPressed:  () {Navigator.pop(context);},
                                  //           )
                                  //         ],
                                  //       );
                                  //     }
                                  // );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.delete,color: Colors.red,),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
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