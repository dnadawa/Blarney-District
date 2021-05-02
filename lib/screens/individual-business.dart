import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/icon-text-button.dart';
import 'package:village_app/widgets/toast.dart';

class IndividualBusiness extends StatefulWidget {
  final String image;
  final String description;
  final String phone;
  final String facebook;
  final String instagram;
  final String twitter;
  final String address;
  final String rating;
  final int reviews;
  final double lat;
  final double long;
  final List checkIns;
  final List favourites;
  final String id;

  const IndividualBusiness({Key key, this.image, this.description, this.phone, this.facebook, this.instagram, this.twitter, this.address, this.rating, this.reviews, this.lat, this.long, this.checkIns, this.id, this.favourites}) : super(key: key);
  @override
  _IndividualBusinessState createState() => _IndividualBusinessState();
}

class _IndividualBusinessState extends State<IndividualBusiness> {
  String email;
  List checkIns;
  List favourites;

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : ToastBar(text: 'Something went wrong!',color: Colors.red).show();

  getLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedUser();
    checkIns = widget.checkIns;
    favourites = widget.favourites;
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
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///image
              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(500),
                child: Image.network(widget.image,fit: BoxFit.cover,),
              ),
              SizedBox(height: ScreenUtil().setWidth(30),),

              ///description
              CustomText(
                text: widget.description,
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
                  GestureDetector(
                    onTap: ()=>_launchURL('tel:${widget.phone}'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.phone,color: Color(0xff0B8A28),size: 20,),
                        SizedBox(width: ScreenUtil().setWidth(20),),
                        CustomText(
                          text: widget.phone,
                          color: Color(0xff0B8A28),
                          size: ScreenUtil().setSp(50),
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  
                  Row(
                    children: [
                      ///facebook
                      GestureDetector(
                        onTap: ()=>_launchURL(widget.facebook),
                        child: SizedBox(
                          width: ScreenUtil().setHeight(80),
                          height: ScreenUtil().setHeight(80),
                          child: Image.asset('images/facebook.png'),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(20),),

                      ///twitter
                      GestureDetector(
                        onTap: ()=>_launchURL(widget.twitter),
                        child: SizedBox(
                          width: ScreenUtil().setHeight(80),
                          height: ScreenUtil().setHeight(80),
                          child: Image.asset('images/twitter.png'),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(20),),

                      ///instagram
                      GestureDetector(
                        onTap: ()=>_launchURL(widget.instagram),
                        child: SizedBox(
                          width: ScreenUtil().setHeight(80),
                          height: ScreenUtil().setHeight(80),
                          child: Image.asset('images/insta.png'),
                        ),
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
                      color:  checkIns.contains(email)?Color(0xff0e6529):Color(0xff0B8A28),
                      text: checkIns.contains(email)?'Checked In':'Check In',
                      icon: Icons.check,
                      onTap: () async {
                          if(checkIns.contains(email)){
                            await FirebaseFirestore.instance.collection('businesses').doc(widget.id).update({
                              'checkins': FieldValue.arrayRemove([email])
                            });
                            setState(() {
                              checkIns.remove(email);
                            });
                          }
                          else{
                            await FirebaseFirestore.instance.collection('businesses').doc(widget.id).update({
                              'checkins': FieldValue.arrayUnion([email])
                            });
                            setState(() {
                              checkIns.add(email);
                            });
                          }
                       },
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
                      color: favourites.contains(email)?Color(0xff9e8721):Color(0xffC7A92B),
                      text: favourites.contains(email)?'Added to Favourites':'Add to Favourites',
                      icon: Icons.favorite,
                      onTap: () async {
                        if(favourites.contains(email)){
                          await FirebaseFirestore.instance.collection('businesses').doc(widget.id).update({
                            'favourites': FieldValue.arrayRemove([email])
                          });
                          setState(() {
                            favourites.remove(email);
                          });
                        }
                        else{
                          await FirebaseFirestore.instance.collection('businesses').doc(widget.id).update({
                            'favourites': FieldValue.arrayUnion([email])
                          });
                          setState(() {
                            favourites.add(email);
                          });
                        }
                      },
                    ),
                  ),

                ],
              ),
              SizedBox(height: ScreenUtil().setWidth(60),),

              ///address
              GestureDetector(
                onTap: ()=>_launchURL('https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.room,color: Color(0xff3800D3),size: 20,),
                    SizedBox(width: ScreenUtil().setWidth(20),),
                    CustomText(
                      text: widget.address,
                      color: Color(0xff3800D3),
                      size: ScreenUtil().setSp(50),
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setWidth(30),),

              ///map
              Container(
                height: ScreenUtil().setHeight(350),
                color: Colors.green,
                child: GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  markers: {
                    Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(widget.lat, widget.long),
                    )
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.long),
                    zoom: 16,
                  ),
                ),
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
                    rating: double.parse(widget.rating),
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
                    text: '${widget.rating}/5.0\n(${widget.reviews} Reviews)',
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
