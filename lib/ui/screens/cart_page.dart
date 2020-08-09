import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/provider/card_provider.dart';

import 'package:ecommer_user_side/ui/screens/google_map.dart';
import 'package:ecommer_user_side/ui/screens/login_screen.dart';
import 'package:ecommer_user_side/ui/widgets/custom_dialog.dart';
import 'package:ecommer_user_side/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final BuildContext context;
  CartScreen(this.context);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  getTotal() async {
    await Provider.of<CardProvider>(widget.context)
        .getToTalPriceAllCardProduct();
  }

  @override
  void initState() {
    super.initState();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<CardModel>>(
        future: Provider.of<CardProvider>(context).setCards(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CardModel>> snapshot) {
          if (snapshot.hasData) {
            List<CardModel> cardModel = snapshot.data;
            if (cardModel.length > 0) {
              return AnimationLimiter(
                child: ListView.builder(
                    itemCount: cardModel.length,
                    itemBuilder: (_, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: ScaleAnimation(
                            child: Align(
                              alignment: Alignment.topCenter,
                              // heightFactor: 0.7,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (BuildContext context) => DetailsPage(
                                  //           products: cardModel[index],
                                  //         )));
                                },
                                child: Container(
                                  child: Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0xFF075C93)
                                                      .withOpacity(0.3),
                                                  offset: Offset(3, 2),
                                                  blurRadius: 30)
                                            ]),
                                        child: Row(
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      cardModel[index].photoUrl,
                                                  height: 120,
                                                  width: 140,
                                                  fit: BoxFit.fill,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: cardModel[index]
                                                                  .nameProduct +
                                                              "\n",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text:
                                                              "\$${cardModel[index].price} \n\n",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
                                                      TextSpan(
                                                        text: "Quantity: ",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      TextSpan(
                                                        text: cardModel[index]
                                                            .count
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .orangeAccent,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ]),
                                                  ),
                                                  Text(
                                                    "Color: ${cardModel[index].color} ",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () async {
                                          custonDialog(
                                              context: context,
                                              title: 'Warning !!',
                                              description:
                                                  'Your delete product to card',
                                              onYes: () async {
                                                Navigator.pop(context);
                                                await Provider.of<CardProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteCart(
                                                        cardModel[index].docId);

                                                // await Provider.of<CardProvider>(context,
                                                // listen: false)
                                                // .getToTalPriceAllCardProduct();
                                              },
                                              onNo: () {
                                                Navigator.pop(context);
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/cart_empty.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Cart is Empty',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
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
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                    text:
                        " \$${Provider.of<CardProvider>(context).totalPriceAllCard}",
                    style: TextStyle(
                      color: Color(0xFF075C93),
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF075C93).withOpacity(0.8),
                ),
                child: FlatButton(
                    onPressed: () async {
                      await Provider.of<CardProvider>(context, listen: false)
                          .getToTalPriceAllCardProduct();

                      String userInformationUid =
                          await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .getUid();

                      int totalPrice =
                          Provider.of<CardProvider>(context, listen: false)
                              .totalPriceAllCard;
                      if (totalPrice == 0) {
                        custonDialog(
                            context: context,
                            title: 'Warning!!',
                            description:
                                'Yoy Cart in empty Add Product To Cart',
                            btn1: true,
                            onYes: () {
                              Navigator.pop(context);
                            },
                            onNo: () {});
                      } else if (userInformationUid == null) {
                        custonDialog(
                            context: context,
                            title: 'Warning !!',
                            btn1: true,
                            description: 'To Buy this Products you must login',
                            onYes: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignIn()));
                            },
                            onNo: () {});
                      } else {
                        // await Provider.of<CardProvider>(context,
                        // listen: false)
                        // .getToTalPriceAllCardProduct();
                        custonDialog(
                            context: context,
                            title: 'Success',
                            description:
                                ' You Total Price order is $totalPrice',
                            onYes: () async {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GoogleMapExample(),
                              ));
                            },
                            onNo: () async {
                              //  await Provider.of<CardProvider>(context,
                              // listen: false)
                              // .getToTalPriceAllCardProduct();
                              Navigator.pop(context);
                            });
                      }
                    },
                    child: Text(
                      "Check out",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
