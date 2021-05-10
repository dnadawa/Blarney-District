import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/screens/admin/add-offer.dart';
import 'package:village_app/screens/individual-offer.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/toast.dart';
import 'package:http/http.dart' as http;

class SpecialOffers extends StatefulWidget {
  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  List<DocumentSnapshot> offers;
  StreamSubscription<QuerySnapshot> subscription;
  bool isAdmin = false;
  getOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool('isAdmin') ?? false;
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
      floatingActionButton: isAdmin?FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AddOffer()),
          );
        },
      ):null,
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
                    return Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Center(
                          child: Padding(
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
                          ),
                        ),

                        ///buttons
                        if(isAdmin)
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ///edit button
                              GestureDetector(
                                onTap: () async {
                                  ToastBar(text: 'Please wait...',color: Colors.orange).show();
                                  var response = await http.get(Uri.parse(offers[i]['image']));
                                  var dir = await getTemporaryDirectory();
                                  File image = File(dir.path+'/${DateTime.now().millisecondsSinceEpoch.toString()}.png');
                                  image.writeAsBytesSync(response.bodyBytes);

                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) => AddOffer(
                                      title: offers[i]['offer'],
                                      description: offers[i]['description'],
                                      businessNameAndID: offers[i]['business']+"+"+offers[i]['businessId'],
                                      image: image,
                                      id: offers[i].id,
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
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          content: CustomText(text: 'Are you sure you want to remove this offer?',color: Colors.black,),
                                          actions: [
                                            TextButton(
                                              child: CustomText(text: 'Yes',color: Colors.black,isBold: true,size: ScreenUtil().setSp(35),),
                                              onPressed:  () async {
                                                try{
                                                  await FirebaseFirestore.instance.collection('offers').doc(offers[i].id).delete();
                                                  ToastBar(text: 'Offer Removed!',color: Colors.green).show();
                                                  Navigator.pop(context);
                                                }
                                                catch(e){
                                                  ToastBar(text: 'Something went wrong',color: Colors.red).show();
                                                }
                                              },
                                            ),
                                            TextButton(
                                              child: CustomText(text: 'No',color: Colors.black, isBold: true, size: ScreenUtil().setSp(35),),
                                              onPressed:  () {Navigator.pop(context);},
                                            )
                                          ],
                                        );
                                      }
                                  );
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
