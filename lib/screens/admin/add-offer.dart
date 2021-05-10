import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/input-field.dart';
import 'package:village_app/widgets/toast.dart';

class AddOffer extends StatefulWidget {
  final String title;
  final String description;
  final String businessNameAndID;
  final File image;
  final String id;

  const AddOffer({Key key, this.title, this.description, this.businessNameAndID, this.image, this.id}) : super(key: key);
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  File image;
  List<DropdownMenuItem<String>> businessList = [];
  String businessName;
  TextEditingController description = TextEditingController();
  TextEditingController offer = TextEditingController();

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

  getBusinesses() async {
    var sub = await FirebaseFirestore.instance.collection('businesses').get();
    var business = sub.docs;
    if(business.isNotEmpty){
      for(int i=0;i<business.length;i++){
        businessName = business[0]['name']+"+"+business[0].id;
        businessList.add(
          DropdownMenuItem(child: CustomText(text: business[i]['name'],color: Colors.white,),value: business[i]['name']+"+"+business[i].id,),
        );
      }
      setState(() {});
    }
  }


  setEditDetails(){
    if(widget.title!=null&&widget.description!=null&&widget.image!=null&&widget.businessNameAndID!=null){
      setState(() {
        offer.text = widget.title;
        description.text = widget.description;
        businessName = widget.businessNameAndID;
        image = widget.image;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusinesses();
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
                InputField(hint: 'Offer Title',controller: offer,),
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
                      hintText: 'Offer Description'
                    ),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.fromLTRB(ScreenUtil().setSp(40),ScreenUtil().setSp(60),ScreenUtil().setSp(40),0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(text: 'Business Name',size: 16,color: Colors.black,isBold: true,align: TextAlign.start,)),
                ),
                Center(
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(ScreenUtil().setSp(40),ScreenUtil().setSp(40),ScreenUtil().setSp(40),0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                        child: DropdownButton(
                          underline: Divider(color: Theme.of(context).primaryColor,height: 0,thickness: 0,),
                          dropdownColor: Theme.of(context).primaryColor,
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          items: businessList,
                          onChanged:(newValue){
                              setState(() {
                                businessName = newValue;
                              });
                          },
                          value: businessName,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                  child: Button(
                    text: 'Submit',
                    color: Theme.of(context).primaryColor,
                    textColor: Color(0xffC7A92B),
                    onclick: () async {
                      ToastBar(text: 'Please wait',color: Colors.orange).show();
                      try{
                        if(description.text.isNotEmpty && offer.text.isNotEmpty && image!=null){

                          ///update
                          if(widget.id!=null){
                            ///upload image
                            FirebaseStorage storage = FirebaseStorage.instance;
                            TaskSnapshot snap = await storage.ref('offers/'+widget.id).putFile(image);
                            String url = await snap.ref.getDownloadURL();

                            ///update order
                            await FirebaseFirestore.instance.collection('offers').doc(widget.id).update({
                              'business': businessName.split('+')[0],
                              'businessId': businessName.split('+')[1],
                              'description': description.text,
                              'image': url,
                              'offer': offer.text
                            });

                            ToastBar(text: 'Offer Updated!',color: Colors.green).show();
                            Navigator.pop(context);
                          }

                          ///create new
                          else{
                            ///upload image
                            FirebaseStorage storage = FirebaseStorage.instance;
                            TaskSnapshot snap = await storage.ref('offers/'+DateTime.now().millisecondsSinceEpoch.toString()).putFile(image);
                            String url = await snap.ref.getDownloadURL();


                            ///send to database
                            await FirebaseFirestore.instance.collection('offers').add({
                              'business': businessName.split('+')[0],
                              'businessId': businessName.split('+')[1],
                              'description': description.text,
                              'image': url,
                              'offer': offer.text
                            });

                            ///send notifications
                            var sub = await FirebaseFirestore.instance.collection('users').get();
                            var users = sub.docs;
                            List playerIds = [];
                            if(users.isNotEmpty){
                              for(int i=0;i<users.length;i++){
                                try{
                                  playerIds.add(users[i]['playerId']);
                                }
                                catch(e){
                                  print("No player ID for user ${users[i]['email']}");
                                }
                              }

                              OneSignal.shared.postNotification(OSCreateNotification(
                                playerIds: List<String>.from(playerIds),
                                content: offer.text,
                                heading: "New Special Offer at ${businessName.split('+')[0]}",
                              ));


                            }

                            ToastBar(text: 'Offer Added!',color: Colors.green).show();
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
