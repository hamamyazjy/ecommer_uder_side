import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class FiltersProductsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filte'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<Products>>(
            future: Provider.of<FilterProvider>(context).filterProduxts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<Products> products = snapshot.data;
                if (products.length > 0) {
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) => Details(
                              //           products: products[index],
                              //         )));
                            },
                            child: Container(
                              height: 220,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        offset: Offset(-2, -1),
                                        blurRadius: 5),
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Stack(
                                      children: <Widget>[
                                        // Positioned.fill(
                                        //     child: Align(
                                        //   alignment: Alignment.center,
                                        //   child: Loading(),
                                        // )),
                                        Center(
                                            child: CachedNetworkImage(
                                                height: 126,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    products[index].photoUrl))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          products[index].nameProduct ??
                                              "id null",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Rate',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "\$${products[index].price}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
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
        ));
  }
}
