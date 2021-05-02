import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/screens/individual-offer.dart';
import 'package:village_app/widgets/custom-text.dart';

class SpecialOffers extends StatefulWidget {
  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  List<DocumentSnapshot> offers;
  StreamSubscription<QuerySnapshot> subscription;

  getOffers(){
    subscription = FirebaseFirestore.instance.collection('offers').snapshots().listen((datasnapshot){
      setState(() {
        offers = datasnapshot.docs;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOffers();
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
              text: 'Special Offers',
              size: ScreenUtil().setSp(100),
              color: Colors.black,
            ),
          ),

          Expanded(
            child: Padding(
              padding:  EdgeInsets.all(ScreenUtil().setHeight(25)),
              child: offers!=null?ListView.builder(
                  itemCount: offers.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding:  EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => IndividualOffer(
                              image: offers[i]['image'],
                              description: offers[i]['description'],
                              business: offers[i]['business'],
                              offer: offers[i]['offer'],
                            )),
                          );
                        },
                        child: Container(
                          height: ScreenUtil().setHeight(600),
                          child: FadeInImage(
                            placeholder: AssetImage('images/logo.png'),
                            image: NetworkImage(offers[i]['image']),
                          ),
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
