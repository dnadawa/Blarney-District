import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InputField extends StatelessWidget {

  final String hint;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController controller;


  const InputField({Key key, this.hint, this.type, this.isPassword=false, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(ScreenUtil().setSp(40),ScreenUtil().setSp(60),ScreenUtil().setSp(40),0),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        keyboardType: type,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          enabledBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 5),
          ),

        ),
      ),
    );
  }
}