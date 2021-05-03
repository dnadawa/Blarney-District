import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<DocumentSnapshot> notifications;
  StreamSubscription<QuerySnapshot> subscription;

  getNotifications(){
    subscription = FirebaseFirestore.instance.collection('notifications').orderBy('time', descending: true).snapshots().listen((datasnapshot){
      setState(() {
        notifications = datasnapshot.docs;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
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
      appBar: AppBar(
        title: SizedBox(
            width: ScreenUtil().setWidth(350),
            child: Image.asset('images/logo.png')),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
            child: CustomText(
              text: 'Notifications',
              size: ScreenUtil().setSp(100),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: notifications!=null?ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, i){
                String title = notifications[i]['title'];
                String content = notifications[i]['content'];


                return ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  title: CustomText(
                    text: title,
                    color: Colors.black,
                    align: TextAlign.start,
                    isBold: true,
                  ),
                  subtitle: CustomText(
                    text: content,
                    color: Colors.black,
                    align: TextAlign.start,
                  ),
                );
              },
            ):Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),),
          ),
        ],
      ),
    );
  }
}
