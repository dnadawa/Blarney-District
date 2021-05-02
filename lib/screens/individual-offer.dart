import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:village_app/widgets/custom-text.dart';

class IndividualOffer extends StatefulWidget {
  final String image;
  final String offer;
  final String business;
  final String description;

  const IndividualOffer({Key key, this.image, this.offer, this.business, this.description}) : super(key: key);
  @override
  _IndividualOfferState createState() => _IndividualOfferState();
}

class _IndividualOfferState extends State<IndividualOffer> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///offer name
            Padding(
              padding:  EdgeInsets.all(ScreenUtil().setHeight(40)),
              child: CustomText(
                text: widget.offer,
                isBold: true,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(80),
                align: TextAlign.start,
              ),
            ),

            ///image
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(40)),
              child: Container(
                height: ScreenUtil().setHeight(600),
                child: Image.network(widget.image),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(50),),

            ///businessName
            Container(
              color: Color(0xffBF5154),
              child: ListTile(
                leading: Container(
                  width: ScreenUtil().setHeight(100),
                  height: ScreenUtil().setHeight(100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.home_work_outlined,color: Theme.of(context).primaryColor,),
                ),
                title: CustomText(
                  text: widget.business,
                  isBold: true,
                  align: TextAlign.start,
                  size: ScreenUtil().setSp(65),
                ),
              ),
            ),

            ///description
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(40)),
              child: CustomText(
                text: widget.description,
                align: TextAlign.justify,
                color: Colors.black,
                size: ScreenUtil().setSp(45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
