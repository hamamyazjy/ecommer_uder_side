import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/provider/card_provider.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:stepo/stepo.dart';

import '../app_theme.dart';

class CourseInfoScreen extends StatefulWidget {
  final products;

  CourseInfoScreen({this.products});
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  int countProduct = 1;

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    CardProvider pr = Provider.of<CardProvider>(context);

    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return SafeArea(
      child: Container(
        color: AppTheme.nearlyWhite,
        child: Scaffold(
          key: _keyScaffold,
          // backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                    tag: widget.products.photoUrl,
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: CachedNetworkImage(
                        placeholder: (context, url) => SpinKitRotatingCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                        imageUrl: widget.products.photoUrl,
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: infoHeight,
                            maxHeight: tempHeight > infoHeight
                                ? tempHeight
                                : infoHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 18, right: 16),
                              child: Text(
                                widget.products.nameProduct,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  // color: AppTheme.darkerText,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '\$${widget.products.price}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: AppTheme.nearlyBlue,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '4.3',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: AppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: AppTheme.nearlyBlue,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: <Widget>[
                                    getTimeBoxUI('SIZE', widget.products.size),
                                    getTimeBoxUI(
                                        'COLOR', widget.products.color),
                                    // getTimeBoxUI('24', 'Seat'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  child: ExpandableText(
                                    widget.products.detailsProduct,
                                    textAlign: TextAlign.justify,
                                    collapseText: 'Show Less',
                                    expandText: 'Show More ',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, bottom: 50, right: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 48,
                                      height: 48,
                                      child: GestureDetector(
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: <Widget>[
                                                          Text(
                                                            'Size',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Container(
                                                              width: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              child: Consumer<
                                                                  ProductsProvider>(
                                                                builder: (BuildContext
                                                                        context,
                                                                    ProductsProvider
                                                                        value,
                                                                    Widget
                                                                        child) {
                                                                  return DropdownButtonHideUnderline(
                                                                    child:
                                                                        ButtonTheme(
                                                                      alignedDropdown:
                                                                          true,
                                                                      child:
                                                                          DropdownButton(
                                                                        value: value
                                                                            .selectedSize,
                                                                        items: value
                                                                            .sizes
                                                                            .map((e) =>
                                                                                DropdownMenuItem(
                                                                                  child: Text(e),
                                                                                  value: e,
                                                                                ))
                                                                            .toList(),
                                                                        onChanged:
                                                                            (value1) =>
                                                                                value.changeSelectedSize(value1),
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
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Color',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      Consumer<
                                                          ProductsProvider>(
                                                        builder: (BuildContext
                                                                context,
                                                            ProductsProvider
                                                                value,
                                                            Widget child) {
                                                          return SizedBox(
                                                            height: 70,
                                                            child: ListView
                                                                .builder(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemCount: value
                                                                        .colors
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return GestureDetector(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              width: 50,
                                                                              height: 200,
                                                                              decoration: BoxDecoration(
                                                                                color: value.colors[index],
                                                                                borderRadius: BorderRadius.circular(20),
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
                                                                        onTap:
                                                                            () {
                                                                          value.changeSeclectedColor(
                                                                              index);
                                                                        },
                                                                      );
                                                                    }),
                                                          );
                                                        },
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
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
                                                        backgroundColor: Colors
                                                            .green
                                                            .withOpacity(0.7),
                                                        style: Style.horizontal,
                                                        textColor: Colors.white,
                                                        animationDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    300),
                                                        iconColor: Colors.black,
                                                        initialCounter: 1,
                                                        onIncrementClicked:
                                                            (counter) {
                                                          countProduct =
                                                              ++counter;
                                                          print(countProduct);
                                                        },
                                                        onDecrementClicked:
                                                            (counter) {
                                                          countProduct =
                                                              --counter;
                                                          print(countProduct);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: FlatButton(
                                                          onPressed: () async {
                                                            String uId =
                                                                await Provider.of<
                                                                            AuthProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .getUid();

                                                            if (uId != null) {
                                                              CardModel
                                                                  cardModel =
                                                                  CardModel(
                                                                categories: widget
                                                                    .products
                                                                    .categories,
                                                                userId: uId,
                                                                color: Provider.of<
                                                                            ProductsProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .selectedNameColor,
                                                                count:
                                                                    countProduct,
                                                                detailsProduct:
                                                                    widget
                                                                        .products
                                                                        .detailsProduct,
                                                                price: widget
                                                                    .products
                                                                    .price,
                                                                nameProduct: widget
                                                                    .products
                                                                    .nameProduct,
                                                                photoUrl: widget
                                                                    .products
                                                                    .photoUrl,
                                                                size: Provider.of<
                                                                            ProductsProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .selectedSize,
                                                              );

                                                              await Provider.of<
                                                                          CardProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .addCartToFireBase(
                                                                      cardModel);

                                                              _keyScaffold
                                                                  .currentState
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    'Add Sucsses To Cart'),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                              ));

                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              _keyScaffold
                                                                  .currentState
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    'Please login '),
                                                                backgroundColor:
                                                                    Colors.red,
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
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    50),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50),
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
                                          decoration: BoxDecoration(
                                            color: AppTheme.nearlyWhite,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            border: Border.all(
                                                color: AppTheme.grey
                                                    .withOpacity(0.2)),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: AppTheme.nearlyBlue,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: AppTheme.nearlyBlue,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: AppTheme.nearlyBlue
                                                    .withOpacity(0.5),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 10.0),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Join Course',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              color: AppTheme.nearlyWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                right: 35,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: CurvedAnimation(
                      parent: animationController, curve: Curves.fastOutSlowIn),
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
                    child: Card(
                      color: AppTheme.nearlyBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 10.0,
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Center(
                          child: Icon(
                            Provider.of<ProductsProvider>(context)
                                    .likeListProduct
                                    .contains(widget.products.nameProduct)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Provider.of<ProductsProvider>(context)
                                    .likeListProduct
                                    .contains(widget.products.nameProduct)
                                ? Colors.red
                                : AppTheme.nearlyWhite,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding:
              //       EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              //   child: SizedBox(
              //     width: AppBar().preferredSize.height-10,
              //     height: AppBar().preferredSize.height-10,
              //     child: Material(
              //       color: Colors.transparent,
              //       child: InkWell(
              //         borderRadius:
              //             BorderRadius.circular(AppBar().preferredSize.height),
              //         child: Icon(
              //           Icons.arrow_back_ios,
              //           color: AppTheme.nearlyBlack,
              //         ),
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
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
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: AppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: AppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
