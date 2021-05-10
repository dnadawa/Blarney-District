import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/input-field.dart';
import 'package:village_app/widgets/toast.dart';

class AddBusiness extends StatefulWidget {

  final String name;
  final String description;
  final String phone;
  final String facebook;
  final String twitter;
  final String instagram;
  final String address;
  final double lat;
  final double long;
  final List checkins;
  final List favourites;
  final String rating;
  final int reviews;
  final File image;
  final String id;

  const AddBusiness({Key key, this.name, this.description, this.phone, this.facebook, this.twitter, this.instagram, this.address, this.lat, this.long, this.checkins, this.favourites, this.rating, this.reviews, this.image, this.id}) : super(key: key);


  @override
  _AddBusinessState createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  File image;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();

  setEditDetails(){
    if(widget.id!=null){
      setState(() {
       name.text = widget.name;
       description.text = widget.description;
       phone.text = widget.phone;
       facebook.text = widget.facebook;
       twitter.text = widget.twitter;
       instagram.text = widget.instagram;
       address.text = widget.address;
       lat.text = widget.lat.toString();
       long.text = widget.long.toString();
       image = widget.image;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        ToastBar(text: 'No image selected',color: Colors.red).show();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setEditDetails();
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
      ),
      body: Padding(
        padding:  EdgeInsets.all(ScreenUtil().setHeight(40)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(50)),
                  child: GestureDetector(
                    onTap: ()=>getImage(),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage: image==null?null:FileImage(image),
                      child: image==null?Icon(Icons.camera_alt,color: Colors.white,size: 40,):null,
                    ),
                  ),
                ),
                CustomText(text: 'Upload Image',size: 16,color: Colors.black,),
                InputField(hint: 'Name',controller: name,),
                Padding(
                  padding:  EdgeInsets.fromLTRB(ScreenUtil().setSp(40),ScreenUtil().setSp(60),ScreenUtil().setSp(40),0),
                  child: TextField(
                    controller: description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder:UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 5),
                        ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        hintText: 'Description'
                    ),
                  ),
                ),
                InputField(hint: 'Phone',controller: phone,),
                InputField(hint: 'Facebook URL (Please include https://)',controller: facebook,),
                InputField(hint: 'Twitter URL (Please include https://)',controller: twitter,),
                InputField(hint: 'Instagram URL (Please include https://)',controller: instagram,),
                InputField(hint: 'Address',controller: address,),
                InputField(hint: 'Latitude',controller: lat,),
                InputField(hint: 'Longitude',controller: long,),



                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                  child: Button(
                    text: 'Submit',
                    color: Theme.of(context).primaryColor,
                    textColor: Color(0xffC7A92B),
                    onclick: () async {
                      ToastBar(text: 'Please wait',color: Colors.orange).show();
                      try{
                        if(description.text.isNotEmpty && name.text.isNotEmpty && phone.text.isNotEmpty && facebook.text.isNotEmpty && instagram.text.isNotEmpty && twitter.text.isNotEmpty && address.text.isNotEmpty && lat.text.isNotEmpty && long.text.isNotEmpty && image!=null){
                          ///update
                          if(widget.id!=null){
                            ///upload image
                            FirebaseStorage storage = FirebaseStorage.instance;
                            TaskSnapshot snap = await storage.ref('business/'+widget.id).putFile(image);
                            String url = await snap.ref.getDownloadURL();

                            ///send to database
                            await FirebaseFirestore.instance.collection('businesses').doc(widget.id).update({
                              'address': address.text,
                              'checkins': widget.checkins,
                              'description': description.text,
                              'facebook': facebook.text,
                              'favourites': widget.favourites,
                              'image': url,
                              'instagram': instagram.text,
                              'lat': double.parse(lat.text),
                              'long': double.parse(long.text),
                              'name': name.text,
                              'phone': phone.text,
                              'rating': double.parse(widget.rating),
                              'reviews': widget.reviews,
                              'twitter': twitter.text
                            });

                            ToastBar(text: 'Business Updated!',color: Colors.green).show();
                            Navigator.pop(context);
                          }

                          ///create new
                          else{
                            ///upload image
                            FirebaseStorage storage = FirebaseStorage.instance;
                            TaskSnapshot snap = await storage.ref('business/'+DateTime.now().millisecondsSinceEpoch.toString()).putFile(image);
                            String url = await snap.ref.getDownloadURL();

                            ///send to database
                            await FirebaseFirestore.instance.collection('businesses').add({
                              'address': address.text,
                              'checkins': [],
                              'description': description.text,
                              'facebook': facebook.text,
                              'favourites': [],
                              'image': url,
                              'instagram': instagram.text,
                              'lat': double.parse(lat.text),
                              'long': double.parse(long.text),
                              'name': name.text,
                              'phone': phone.text,
                              'rating': 0,
                              'reviews': 0,
                              'twitter': twitter.text
                            });

                            ToastBar(text: 'Business Added!',color: Colors.green).show();
                            Navigator.pop(context);
                          }

                        }
                        else{
                          ToastBar(text: 'Please fill all fields!',color: Colors.red).show();
                        }

                      }
                      catch(e){
                        ToastBar(text: 'Something went wrong',color: Colors.red).show();
                      }
                   },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
