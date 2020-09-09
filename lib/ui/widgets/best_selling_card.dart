 import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CardBestSelling extends StatelessWidget {
  final Products products;

  CardBestSelling({this.products});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(200),
            decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  products.photoUrl 
                ),
              ),
              borderRadius: BorderRadius.circular(4.00),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
           products.nameProduct,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            "Tag Heuer",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff929292),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            "\$ ${products.price}",
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xff00c569),
            ),
          ),
        ],
      ),
    );
  }
}
