import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';

import 'individual-business.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};

  getBusiness() async {
    var sub = await FirebaseFirestore.instance.collection('businesses').get();
    List business = sub.docs;
    BitmapDescriptor pin = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 1), 'images/marker.png');

    for(int i=0;i<business.length;i++){
      _markers.add(
        Marker(
          markerId: MarkerId(business[i]['name']),
          position: LatLng(business[i]['lat'], business[i]['long']),
          // icon: BitmapDescriptor.defaultMarkerWithHue(30),
          icon: pin,
          onTap: (){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  return Container(
                    height: MediaQuery.of(context).size.height/3,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(35)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: Image.network(business[i]['image']),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(30),),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(25)),
                            child: CustomText(
                              text: business[i]['name'],
                              color: Theme.of(context).primaryColor,
                              size: ScreenUtil().setSp(70),
                              isBold: true,
                              align: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(ScreenUtil().setHeight(25)),
                            child: Button(
                              color: Theme.of(context).primaryColor,
                              text: 'View',
                              onclick: (){
                                String name = business[i]['name'];
                                String description = business[i]['description'];
                                String phone = business[i]['phone'];
                                String address = business[i]['address'];
                                String facebook = business[i]['facebook'];
                                String twitter = business[i]['twitter'];
                                String instagram = business[i]['instagram'];
                                String image = business[i]['image'];
                                String rating = business[i]['rating'].toString();
                                int reviews = business[i]['reviews'];
                                double lat = business[i]['lat'];
                                double long = business[i]['long'];
                                List checkIns = business[i]['checkins'];
                                List favourites = business[i]['favourites'];
                                String id = business[i].id;

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
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        )
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        rotateGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(7.8731, 80.7718),
          zoom: 7,
        ),
        markers: _markers,
      ),
    );
  }
}
