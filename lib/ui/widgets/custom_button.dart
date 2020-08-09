import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  CustomButton({this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        height: ScreenUtil().setHeight(60),
        width: ScreenUtil().setWidth(300),
        decoration: BoxDecoration(
          color: Color(0xff00c569),
          borderRadius: BorderRadius.circular(4.00),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}
