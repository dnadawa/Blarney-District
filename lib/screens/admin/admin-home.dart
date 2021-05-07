import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/screens/business-directory.dart';
import 'package:village_app/screens/special-offers.dart';
import 'package:village_app/widgets/toast.dart';

import '../../notifications.dart';
import '../welcome.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with SingleTickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2,initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            width: ScreenUtil().setWidth(350),
            child: Image.asset('images/logo.png')),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            prefs.remove('name');
            prefs.remove('image');
            prefs.remove('isAdmin');
            Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) =>
                    Welcome()), (Route<dynamic> route) => false);
            ToastBar(text: 'Logged out!',color: Colors.green).show();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => Notifications()),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.local_offer),
            ),
            Tab(
              icon: Icon(Icons.store_mall_directory),
            )
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SpecialOffers(),
          BusinessDirectory(),
        ],
      ),

    );
  }
}
