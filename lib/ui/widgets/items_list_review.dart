import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ItemsListTReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return Card(
        child: Container(
      padding: EdgeInsets.all(
        ScreenUtil().setHeight(10),
      ),
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 46.00,
            width: 46.00,
            decoration: BoxDecoration(
              color: Colors.red,
              //   image: DecorationImage(
              //   image: AssetImage("assets/Avatar.png"),
              // ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Samuel Smith",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(75),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.star_border,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  "Wonderful jean, perfect  gift for my girl for our anniversary!",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
