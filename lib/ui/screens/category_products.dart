import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/models/type_model.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class DestinationScreen extends StatefulWidget {
  final TypeModel typeModel;

  DestinationScreen({this.typeModel});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  // Text _buildRatingStars(int rating) {
  //   String stars = '';
  //   for (int i = 0; i < rating; i++) {
  //     stars += '⭐ ';
  //   }
  //   stars.trim();
  //   return Text(stars);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.typeModel.image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage(widget.typeModel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.typeModel.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     Icon(
                    //       FontAwesomeIcons.locationArrow,
                    //       size: 15.0,
                    //       color: Colors.white70,
                    //     ),
                    //     SizedBox(width: 5.0),
                    // Text(
                    //   widget.typeModel.name,
                    //   style: TextStyle(
                    //     color: Colors.white70,
                    //     fontSize: 20.0,
                    //   ),
                    // ),
                    // ],
                    // ),
                  ],
                ),
              ),
              // Positioned(
              //   right: 20.0,
              //   bottom: 20.0,
              //   child: Icon(
              //     Icons.location_on,
              //     color: Colors.white70,
              //     size: 25.0,
              //   ),
              // ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Products>>(
              future: widget.typeModel.name != null
                  ? Provider.of<ProductsProvider>(context)
                      .getProductsByCateory(widget.typeModel.name)
                  : Provider.of<ProductsProvider>(context).setProducts(),
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  List<Products> products = asyncSnapshot.data;
                  if (products.length > 0) {
                    return AnimationLimiter(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          Products pr = products[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: products.length,
                            child: ScaleAnimation(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        40.0, 5.0, 20.0, 5.0),
                                    height: 170.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          100.0, 20.0, 20.0, 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 120.0,
                                                child: Text(
                                                  pr.nameProduct,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Text(
                                                '\$${pr.price}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            pr.color,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          // _buildRatingStars(pr.categories),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: Alignment.center,
                                                // child: Text(
                                                //   activity.startTimes[0],
                                                // ),
                                              ),
                                              SizedBox(width: 10.0),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: Alignment.center,
                                                // child: Text(
                                                //   activity.startTimes[1],
                                                // ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 30,
                                    child: Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Provider.of<ProductsProvider>(context,
                                                  listen: false)
                                              .changeLikeProduct(
                                                  pr.nameProduct,
                                                  CardModel(
                                                      color: pr.color,
                                                      detailsProduct:
                                                          pr.detailsProduct,
                                                      nameProduct:
                                                          pr.nameProduct,
                                                      photoUrl: pr.photoUrl,
                                                      price: pr.price,
                                                      size: pr.size,
                                                      userId: Provider.of<
                                                                  ProductsProvider>(
                                                              context,
                                                              listen: false)
                                                          .uId));
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white),
                                          child: Center(
                                            child: Icon(
                                              Provider.of<ProductsProvider>(
                                                          context)
                                                      .likeListProduct
                                                      .contains(pr.nameProduct)
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
                                    left: 20.0,
                                    top: 15.0,
                                    bottom: 15.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        width: 110.0,
                                        image: CachedNetworkImageProvider(
                                            pr.photoUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
