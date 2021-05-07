import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:village_app/widgets/button.dart';
import 'package:village_app/widgets/custom-text.dart';
import 'package:village_app/widgets/input-field.dart';
import 'package:village_app/widgets/toast.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  File image;
  String url;

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

  signUp() async {
    if(fName.text.isNotEmpty && lName.text.isNotEmpty && email.text.isNotEmpty &&password.text.isNotEmpty && image!=null){
      ToastBar(text: 'Please wait',color: Colors.orange).show();
      ///auth
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text
        );


        ///upload pro pic
        FirebaseStorage storage = FirebaseStorage.instance;
        TaskSnapshot snap = await storage.ref('profiles/'+email.text).putFile(image);
        url = await snap.ref.getDownloadURL();

        ///save details
        await FirebaseFirestore.instance.collection('users').doc(email.text).set({
          'fname': fName.text,
          'lname': lName.text,
          'image': url,
          'email': email.text,
          'joined': DateTime.now().toString()
        });

        ToastBar(text: 'User registered!',color: Colors.green).show();
        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ToastBar(text: 'The password provided is too weak',color: Colors.red).show();
        } else if (e.code == 'email-already-in-use') {
          ToastBar(text: 'The account already exists for that email',color: Colors.red).show();
        }
      } catch (e) {
        ToastBar(text: 'Something went wrong',color: Colors.red).show();
      }
    }
    else{
      ToastBar(text: 'Please fill all fields',color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(ScreenUtil().setHeight(40)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Create your account',size: ScreenUtil().setSp(80),color: Colors.black,isBold: true,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(50)),
                  child: GestureDetector(
                    onTap: ()=>getImage(),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: image==null?AssetImage('images/avatar.png'):FileImage(image),
                    ),
                  ),
                ),
                CustomText(text: 'Upload your profile picture',size: 16,color: Colors.black,),
                InputField(hint: 'First Name',controller: fName,),
                InputField(hint: 'Last Name',controller: lName,),
                InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
                InputField(hint: 'Password',isPassword:true,controller: password,),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
                  child: Button(
                    text: 'Sign Up',
                    color: Theme.of(context).primaryColor,
                    textColor: Color(0xffC7A92B),
                    onclick: ()=>signUp(),
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
