import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom-text.dart';

class IconTextButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function onTap;

  const IconTextButton({Key key, this.color, this.icon, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Expanded(
              child: CustomText(
                text: text,
                isBold: true,
                size: ScreenUtil().setSp(33),
              ),
            )
          ],
        ));
  }
}
