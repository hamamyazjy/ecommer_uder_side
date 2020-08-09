import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/provider/card_provider.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:expandable_text/expandable_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:stepo/stepo.dart';

class DetailsPage extends StatefulWidget {
  final products;

  DetailsPage({this.products});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    animation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutSine);

    animationController.forward();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   animationController.dispose();
  // }

  int countProduct = 1;

  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    CardProvider pr = Provider.of<CardProvider>(context);
    // ScreenUtil.init(context, width: 370, height: 810);

    return SafeArea(
      child: Scaffold(
          key: _keyScaffold,
          body: Stack(
            children: <Widget>[
              buildListView(context),
              buildCartAndFav(),
              Transform.translate(
                offset: Offset(280, 370),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.black87,
                    child: IconButton(
                      icon: Icon(Icons.star_border, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible:
                                true, // set to false if you want to force a rating
                            builder: (context) {
                              return RatingDialog(
                                icon: const Icon(
                                  Icons.star,
                                  size: 100,
                                  color: Colors.blue,
                                ), // set your own image/icon widget
                                title:
                                    "Rating ${widget.products.nameProduct} product ",
                                description: "Tap a star to give your rating.",
                                submitButton: "SUBMIT",

                                positiveComment: "We are so happy to hear 😍",
                                negativeComment: "We're sad to hear 😭",
                                accentColor: Colors.blue,
                                onSubmitPressed: (int rating) {
                                  print("onSubmitPressed: rating = $rating");
                                },
                              );
                            });
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0, left: MediaQuery.of(context).size.width - 60.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Badge(
                    badgeContent: Text('${pr.cards.length}'),
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildTopSide(context),
        AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(-180 * (1 - animation.value), 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Text(
                    widget.products.nameProduct,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
              );
            }),
        AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(-200 * (1 - animation.value), 0),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  widget.products.categories == null
                      ? ''
                      : widget.products.categories,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30),
              width: 30,
              height: 2,
              color: Colors.grey,
            ),
            Spacer(),
            Text('4.8'),
            Icon(Icons.star),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(0, 40 * (1 - animation.value)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: ExpandableText(
                    widget.products.detailsProduct,
                    collapseText: 'Show Less',
                    expandText: 'Show More ',
                    maxLines: 2,
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget buildTopSide(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        buildImage(),
        buildTextBox(
          'COLOR',
          right: size.width / 2 + 40 + 20,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
        ),
        buildTextBox(
          'PRICE',
          right: size.width / 2 - 40,
          child: Text(
            '\$${widget.products.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        buildTextBox(
          'Size',
          right: size.width / 2 - 40 - 80 - 20,
          child: Text(
            '${widget.products.size}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextBox(String text, {Widget child, double right}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child2) {
        return Positioned(
          height: 70,
          width: 80,
          bottom: 60 * animation.value,
          right: right,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.white.withOpacity(.3),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    child,
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildImage() {
    return
        //  Hero(
        // tag: widget.products.photoUrl,
        AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(0, -180 * (1 - animation.value)),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                    imageUrl: widget.products.photoUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  // )
                ),
              );
            });
  }

  Widget buildCartAndFav() {
    return Positioned(
      bottom: 0.01,
      right: 0.01,
      child: Row(
        children: <Widget>[
          AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: Offset(0, 30 * (1 - animation.value)),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .changeLikeProduct(
                              widget.products.nameProduct,
                              CardModel(
                                  color: widget.products.color,
                                  detailsProduct:
                                      widget.products.detailsProduct,
                                  nameProduct: widget.products.nameProduct,
                                  photoUrl: widget.products.photoUrl,
                                  price: widget.products.price,
                                  size: widget.products.size,
                                  userId: Provider.of<ProductsProvider>(context,
                                          listen: false)
                                      .uId));
                    },
                    child: Container(
                      width: 68,
                      padding: EdgeInsets.all(14),
                      child: Icon(
                        Provider.of<ProductsProvider>(context)
                                .likeListProduct
                                .contains(widget.products.nameProduct)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  // isDismissible: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 500,
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Select details product to add Cart',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Size',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                  child: Consumer<ProductsProvider>(
                                    builder: (BuildContext context,
                                        ProductsProvider value, Widget child) {
                                      return DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton(
                                            value: value.selectedSize,
                                            items: value.sizes
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e),
                                                      value: e,
                                                    ))
                                                .toList(),
                                            onChanged: (value1) => value
                                                .changeSelectedSize(value1),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Color',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Consumer<ProductsProvider>(
                            builder: (BuildContext context,
                                ProductsProvider value, Widget child) {
                              return SizedBox(
                                height: 70,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.colors.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 50,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: value.colors[index],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: index == value.colorClick
                                                  ? Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          value.changeSeclectedColor(index);
                                        },
                                      );
                                    }),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Count',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Stepo(
                            key: UniqueKey(),
                            backgroundColor: Colors.green.withOpacity(0.7),
                            style: Style.horizontal,
                            textColor: Colors.white,
                            animationDuration: Duration(milliseconds: 300),
                            iconColor: Colors.black,
                            initialCounter: 1,
                            onIncrementClicked: (counter) {
                              countProduct = ++counter;
                              print(countProduct);
                            },
                            onDecrementClicked: (counter) {
                              countProduct = --counter;
                              print(countProduct);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () async {
                                String uId = await Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .getUid();

                                if (uId != null) {
                                  CardModel cardModel = CardModel(
                                    categories: widget.products.categories,
                                    userId: uId,
                                    color: Provider.of<ProductsProvider>(
                                            context,
                                            listen: false)
                                        .selectedNameColor,
                                    count: countProduct,
                                    detailsProduct:
                                        widget.products.detailsProduct,
                                    price: widget.products.price,
                                    nameProduct: widget.products.nameProduct,
                                    photoUrl: widget.products.photoUrl,
                                    size: Provider.of<ProductsProvider>(context,
                                            listen: false)
                                        .selectedSize,
                                  );

                                  await Provider.of<CardProvider>(context,
                                          listen: false)
                                      .addCartToFireBase(cardModel);

                                  _keyScaffold.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text('Add Sucsses To Cart'),
                                    backgroundColor: Colors.green,
                                  ));

                                  Navigator.pop(context);
                                } else {
                                  _keyScaffold.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text('Please login '),
                                    backgroundColor: Colors.red,
                                  ));
                                }

                                // List<CardModel> list =
                                //     await Provider.of<CardProvider>(context,
                                //             listen: false)
                                //         .getProductByName(products.nameProduct);

                                // List<String> name =
                                //     list.map((e) => e.nameProduct).toList();

                                // bool isContaine = name.contains(products.nameProduct);

                                // if (isContaine) {
                                //   DbCardProductClient.dbClient.updateStudentById(
                                //       products.nameProduct,
                                //       CardModel(
                                //         color: products.color,
                                //         size: products.size,
                                //         photoUrl: products.photoUrl,
                                //         detailsProduct: products.detailsProduct,
                                //         price: products.price,
                                //         count: countNumber,
                                //         nameProduct: products.nameProduct,
                                //       ).toJson());

                                //   await Provider.of<CardProvider>(context,
                                //           listen: false)
                                //       .getToTalPriceAllCardProduct();
                                // } else {
                                //   await Provider.of<CardProvider>(context,
                                //           listen: false)
                                //       .insertNewProductToCard(CardModel(
                                //           color: products.color,
                                //           size: products.size,
                                //           photoUrl: products.photoUrl,
                                //           detailsProduct: products.detailsProduct,
                                //           price: products.price,
                                //           count: countNumber,
                                //           nameProduct: products.nameProduct));

                                //   await Provider.of<CardProvider>(context,
                                //           listen: false)
                                //       .getToTalPriceAllCardProduct();
                                // }
                              },
                              child: Text(
                                'Add TO Chart',
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              )),
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              width: 68,
              padding: EdgeInsets.all(14),
              child: Icon(
                Icons.shop,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(20),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
