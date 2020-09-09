import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/ui/screens/details_page.dart';
import 'package:ecommer_user_side/ui/screens/info_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem2 extends StatelessWidget {
  final products;

  ListItem2({this.products});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CourseInfoScreen(
              products: products,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
              ),
            ]),
        child: Stack(
          children: <Widget>[
            Container(
              height: 175,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFACBEA3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),

            // Hero(
            //   tag: products.photoUrl,
            Container(
              height: 175,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(products.photoUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              // child: CachedNetworkImage(
              //   fit: BoxFit.cover,
              //   imageUrl: products.photoUrl,
              //   placeholder: (context, url) => SpinKitRotatingCircle(
              //     color: Colors.white,
              //     size: 50.0,
              //   ),
              // ),
            ),
            // ),

            Positioned(
              top: 160,
              right: 20,
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(15),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .changeLikeProduct(
                            products.nameProduct,
                            CardModel(
                                color: products.color,
                                detailsProduct: products.detailsProduct,
                                nameProduct: products.nameProduct,
                                photoUrl: products.photoUrl,
                                price: products.price,
                                size: products.size,
                                userId: Provider.of<ProductsProvider>(context,
                                        listen: false)
                                    .uId));
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Center(
                      child: Icon(
                        Provider.of<ProductsProvider>(context)
                                .likeListProduct
                                .contains(products.nameProduct)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 190,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    products.nameProduct,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 175,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '4.6',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                  size: 14,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "\$${products.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
