import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/models/type_model.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/ui/screens/show_product_category.dart';
import 'package:ecommer_user_side/ui/widgets/categories_type.dart';
import 'package:ecommer_user_side/ui/widgets/category)screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'featured_product.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with TickerProviderStateMixin {
  // final List<TypeModel> typeModel = [
  //   TypeModel(name: 'Baby', image: 'assets/images/baby.jpg'),
  //   TypeModel(name: 'Men', image: 'assets/images/men.jpg'),
  //   TypeModel(name: 'Women', image: 'assets/images/women.jpg'),
  // ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return Scaffold(
      // backgroundColor: Colors.white70,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            FutureBuilder<List<Products>>(
              future: Provider.of<ProductsProvider>(context).setProducts(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<Products> products = snapshot.data;
                  if (products.length > 0) {
                    return Container(
                        height: 200,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            // color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF075C93).withOpacity(0.3),
                                  offset: Offset(3, 2),
                                  blurRadius: 30)
                            ]),
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          images: products
                              .getRange(0, 3)
                              .map(
                                (e) => ClipRRect(
                                    // borderRadius: BorderRadius.all(
                                    //   Radius.circular(20),
                                    // ),
                                    child: CachedNetworkImage(
                                  imageUrl: e.photoUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )),
                              )
                              .toList(),
                          dotSize: 4.0,
                          dotColor: Colors.lightGreenAccent,
                          indicatorBgPadding: 5.0,
                          borderRadius: true,
                          autoplay: false,
                        ));
                  } else {
                    return Center(child: CircularProgressIndicator());
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
            Divider(),
            SizedBox(
              height: 10,
            ),
            MealsListView(),
            // Container(
            //   height: 100,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: typeModel.length,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () async {
            //             Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (BuildContext context) =>
            //                     ShowAllProductsWithCategory(
            //                       nameCategory: typeModel[index].name,
            //                     )));
            //           },
            //           child: CategoryWidget(
            //             typeModel: typeModel[index],
            //           ),
            //         );
            //       }),
            // ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Featured",
                    style: TextStyle(
                      // color: Colors.grey,
                       fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ShowAllProductsWithCategory()));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        // color: Colors.grey, 
                        fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Featured(),
          ],
        ),
      ),
    );
  }
}
