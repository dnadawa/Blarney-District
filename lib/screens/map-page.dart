import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'individual-business.dart';
import 'package:image/image.dart' as image;


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  String _mapStyle;
  GoogleMapController _mapController;

  Future<BitmapDescriptor> createCustomMarkerBitmap(String businessName) async {

    PictureRecorder recorder = new PictureRecorder();
    Canvas c = new Canvas(recorder);

    Future<ui.Image> getUiImage(String imageAssetPath) async {
      final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
      image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List());
      ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(baseSizeImage));
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      return frameInfo.image;
    }

    ui.Image myImage = await getUiImage("images/marker.png");

    paintImage(canvas: c, image: myImage, rect: Rect.fromLTWH(myImage.width.toDouble(), 0, myImage.width.toDouble(), myImage.height.toDouble()));

    TextSpan span = new TextSpan(style: new TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
    ), text: businessName);

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(c, new Offset(0, myImage.height.toDouble()));

    Picture p = recorder.endRecording();
    ByteData pngBytes = await (await p.toImage(myImage.width+tp.width.toInt(), myImage.height+tp.height.toInt())).toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes.buffer);

    return BitmapDescriptor.fromBytes(data);
  }


  getBusiness() async {
    var sub = await FirebaseFirestore.instance.collection('businesses').get();
    List business = sub.docs;
    // BitmapDescriptor pin = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 1), 'images/marker.png');

    for(int i=0;i<business.length;i++){
      BitmapDescriptor pin = await createCustomMarkerBitmap(business[i]['name']);
      _markers.add(
          Marker(
              markerId: MarkerId(business[i]['name']),
              position: LatLng(business[i]['lat'], business[i]['long']),
              // icon: BitmapDescriptor.defaultMarkerWithHue(30),
              icon: pin,
              consumeTapEvents: true,
              onTap: (){
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
    rootBundle.loadString('images/map_style.txt').then((string) {
      _mapStyle = string;
    });
    getBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        rotateGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(51.9336273, -8.5687435),
          zoom: 16,
        ),
        markers: _markers,
        onMapCreated: (controller){
          if (mounted)
            setState(() {
              _mapController = controller;
              controller.setMapStyle(_mapStyle);
            });
        },
      ),
    );
  }
}