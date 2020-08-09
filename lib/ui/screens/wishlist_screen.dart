import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/ui/widgets/custom_drawer.dart';
import 'package:ecommer_user_side/ui/widgets/list_item_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Wishlist',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        drawer: CustomDrawer(),
        body: FutureBuilder(
          future: Provider.of<ProductsProvider>(context).setProductsLikes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<CardModel> wishList = snapshot.data;
              if (wishList.length > 0) {
                return AnimationLimiter(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: wishList.length,
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
                          columnCount: wishList.length,
                          child: ScaleAnimation(
                            child: ScaleAnimation(
                              // FadeInAnimation
                              // SlideAnimation
                              // ScaleAnimation
                              child: ListItem2(
                                products: wishList[index],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // crossAxisSpacing: 3,
                      // mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('No Wish product'),
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
        ));
  }
}
