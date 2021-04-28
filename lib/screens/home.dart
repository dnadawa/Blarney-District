import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/screens/business-directory.dart';
import 'package:village_app/screens/profile.dart';
import 'package:village_app/screens/recent-reviews.dart';
import 'package:village_app/screens/special-offers.dart';
import 'package:village_app/widgets/custom-text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5,initialIndex: 0, vsync: this);
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
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: (){
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => Profile()),
              );
            },
          )
        ],
      ),

      drawer: Drawer(
        child: Container(
          height: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [

              ///profile
              SizedBox(height: ScreenUtil().setHeight(100),),
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.white,),
                title: CustomText(text: 'Hi, Cardi B.',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                onTap: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).accentColor,
                thickness: 1.5,
                indent: ScreenUtil().setHeight(50),
                endIndent: ScreenUtil().setHeight(50),
              ),


              ///map
              ListTile(
                leading: Icon(Icons.map,color: Colors.white,),
                title: CustomText(text: 'Village Map',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
                onTap: (){
                  _tabController.animateTo(0);
                  Navigator.pop(context);
                },
              ),

              ///feed
              ListTile(
                leading: Icon(Icons.web,color: Colors.white,),
                title: CustomText(text: 'Community News',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
                onTap: (){
                  _tabController.animateTo(1);
                  Navigator.pop(context);
                },
              ),

              ///offer
              ListTile(
                leading: Icon(Icons.local_offer,color: Colors.white,),
                title: CustomText(text: 'Special Offers',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
                onTap: (){
                  _tabController.animateTo(2);
                  Navigator.pop(context);
                },
              ),

              ///recent review
              ListTile(
                leading: Icon(Icons.rate_review,color: Colors.white,),
                title: CustomText(text: 'Recent Reviews',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
                onTap: (){
                  _tabController.animateTo(3);
                  Navigator.pop(context);
                },
              ),

              ///business directory
              ListTile(
                leading: Icon(Icons.store_mall_directory,color: Colors.white,),
                title: CustomText(text: 'Business Directory',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
                onTap: (){
                  _tabController.animateTo(4);
                  Navigator.pop(context);
                },
              ),


              ///settings
              Expanded(child: Container()),
              Divider(
                color: Theme.of(context).accentColor,
                thickness: 1.5,
                indent: ScreenUtil().setHeight(50),
                endIndent: ScreenUtil().setHeight(50),
              ),
              ListTile(
                leading: Icon(Icons.settings,color: Colors.white,),
                title: CustomText(text: 'Settings',isBold: true,size: ScreenUtil().setSp(50),align: TextAlign.start,),
              ),
              SizedBox(height: ScreenUtil().setHeight(20),),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.web),
            ),
            Tab(
              icon: Icon(Icons.local_offer),
            ),
            Tab(
              icon: Icon(Icons.rate_review),
            ),
            Tab(
              icon: Icon(Icons.store_mall_directory),
            )
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          SpecialOffers(),
          RecentReviews(),
          BusinessDirectory(),
        ],
      ),

    );
  }
}
