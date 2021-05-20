import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:village_app/screens/welcome.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/input-field.dart';
import 'package:village_app/widgets/toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String image = "";
  int checkIns = 0;
  int reviewsCount = 0;
  int favourites = 0;
  var joined;
  String email;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    var user = sub.docs;

    setState(() {
      name = user[0]['fname'] + " " + user[0]['lname'];
      image = user[0]['image'];
      joined =
          DateFormat('MMMM yyyy').format(DateTime.parse(user[0]['joined']));
    });
  }

  getCheckins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance
        .collection('businesses')
        .where('checkins', arrayContains: email)
        .get();
    var business = sub.docs;

    setState(() {
      checkIns = business.length;
    });
  }

  getFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance
        .collection('businesses')
        .where('favourites', arrayContains: email)
        .get();
    var business = sub.docs;

    setState(() {
      favourites = business.length;
    });
  }

  getReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    var sub = await FirebaseFirestore.instance
        .collection('reviews')
        .where('authorEmail', isEqualTo: email)
        .get();
    var reviews = sub.docs;

    setState(() {
      reviewsCount = reviews.length;
    });
  }

  deleteUser() async {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Deleting Profile...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Center(
            child: CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(35),
            fontWeight: FontWeight.bold));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      bool isFacebook = prefs.getBool('isFacebook') ?? false;
      await pr.show();
      await FirebaseFirestore.instance.collection('users').doc(email).delete();
      await FirebaseFirestore.instance
          .collection('businesses')
          .where('checkins', arrayContains: email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("businesses")
              .doc(element.id)
              .update({
            'checkins': FieldValue.arrayRemove([email])
          });
        });
      });
      await FirebaseFirestore.instance
          .collection('businesses')
          .where('favourites', arrayContains: email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("businesses")
              .doc(element.id)
              .update({
            'favourites': FieldValue.arrayRemove([email])
          });
        });
      });
      if (!isFacebook) {
        await FirebaseAuth.instance.currentUser.delete();
      }
      prefs.remove('email');
      prefs.remove('name');
      prefs.remove('image');
      prefs.remove('isFacebook');
      await pr.hide();
      ToastBar(text: 'User Account Deleted', color: Colors.green).show();
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => Welcome()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        await pr.hide();
        authenticateUser();
        ToastBar(
                text: 'Please reauthenticate before delete user data!',
                color: Colors.red)
            .show();
      }
    }
  }

  authenticateUser() async {
    TextEditingController password = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: CustomText(
            text: "Reauthenticate",
            align: TextAlign.center,
            color: Colors.black,
          ),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputField(
                    hint: 'Enter Password',
                    controller: password,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(130),
                  ),
                  Button(
                    text: 'Delete Data',
                    color: Theme.of(context).primaryColor,
                    onclick: () async {
                      ToastBar(text: 'Please Wait', color: Colors.orange)
                          .show();
                      try {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String email = prefs.getString('email');
                        EmailAuthCredential credential =
                            EmailAuthProvider.credential(
                                email: email, password: password.text);
                        await FirebaseAuth.instance.currentUser
                            .reauthenticateWithCredential(credential);
                        Navigator.pop(context);
                        deleteUser();
                      } catch (e) {
                        ToastBar(
                                text: 'Failed to Authenticate',
                                color: Colors.red)
                            .show();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getCheckins();
    getFavourites();
    getReviews();
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
        actions: [
          IconButton(
              icon: Icon(Icons.person_remove),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: CustomText(
                          text:
                              'Are you sure you want to delete your account? You cannot get the data back',
                          color: Colors.black,
                        ),
                        actions: [
                          TextButton(
                            child: CustomText(
                              text: 'Yes',
                              color: Colors.black,
                              isBold: true,
                              size: ScreenUtil().setSp(35),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              bool isFacebook = prefs.getBool('isFacebook');
                              if (isFacebook) {
                                deleteUser();
                              } else {
                                authenticateUser();
                              }
                            },
                          ),
                          TextButton(
                            child: CustomText(
                              text: 'No',
                              color: Colors.black,
                              isBold: true,
                              size: ScreenUtil().setSp(35),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///pro pic
          GestureDetector(
            onTap: () async {
              final pickedFile = await ImagePicker()
                  .getImage(source: ImageSource.gallery, imageQuality: 50);
              setState(() async {
                if (pickedFile != null) {
                  File image = File(pickedFile.path);

                  ///upload image
                  ToastBar(text: 'Uploading...', color: Colors.orange).show();
                  FirebaseStorage storage = FirebaseStorage.instance;
                  TaskSnapshot snap =
                      await storage.ref('profiles/' + email).putFile(image);
                  String url = await snap.ref.getDownloadURL();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(email)
                      .update({'image': url});
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('image', url);
                  getUser();
                } else {
                  ToastBar(text: 'No image selected', color: Colors.red).show();
                }
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: ScreenUtil().setHeight(150),
              child: ClipOval(
                child: FadeInImage(
                  placeholder: AssetImage('images/avatar.png'),
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  height: ScreenUtil().setHeight(300),
                  width: ScreenUtil().setHeight(300),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(
              text: name,
              color: Colors.black,
              size: ScreenUtil().setSp(70),
              isBold: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
            child: CustomText(
              text: 'Member since $joined',
              color: Colors.black,
              isBold: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(160),
          ),

          ///check in
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(
              text: checkIns.toString(),
              color: Colors.black,
              size: ScreenUtil().setSp(150),
              isBold: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(
              text: 'Check-ins',
              color: Colors.black,
              size: ScreenUtil().setSp(50),
              isBold: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(70),
          ),

          ///reviews
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(
              text: reviewsCount.toString(),
              color: Colors.black,
              size: ScreenUtil().setSp(150),
              isBold: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(
              text: 'Reviews',
              color: Colors.black,
              size: ScreenUtil().setSp(50),
              isBold: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(70),
          ),

          ///favourite
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: CustomText(
              text: favourites.toString(),
              color: Colors.black,
              size: ScreenUtil().setSp(150),
              isBold: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
            child: CustomText(
              text: 'Favourites',
              color: Colors.black,
              size: ScreenUtil().setSp(50),
              isBold: true,
            ),
          ),
        ],
      ),
    );
  }
}
