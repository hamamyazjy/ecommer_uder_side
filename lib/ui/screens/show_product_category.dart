import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/ui/screens/filter_products.dart';
import 'package:ecommer_user_side/ui/widgets/list_item_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ShowAllProductsWithCategory extends StatelessWidget {
  final String nameCategory;

  ShowAllProductsWithCategory({this.nameCategory});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          nameCategory != null ? '$nameCategory Products' : 'Products',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FilterProducts()));
                },
                child: Icon(
                  FontAwesomeIcons.filter,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Products>>(
        future: nameCategory != null
            ? Provider.of<ProductsProvider>(context)
                .getProductsByCateory(nameCategory)
            : Provider.of<ProductsProvider>(context).setProducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Products> products = snapshot.data;
            if (products.length > 0) {
              return AnimationLimiter(
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisSpacing: 3,
                    // mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: products.length,
                        child: ScaleAnimation(
                          child: ScaleAnimation(
                            // FadeInAnimation
                            // SlideAnimation
                            // ScaleAnimation
                            child: ListItem2(
                              products: products[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text('No Products'),
              );
            }
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.black,
                size: 50.0,
              ),
            );
          }
        },
      ),
    );
  }
}
