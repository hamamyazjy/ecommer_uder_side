import 'package:ecommer_user_side/models/orderModel.dart';
import 'package:ecommer_user_side/provider/card_provider.dart';
import 'package:ecommer_user_side/provider/order_provider.dart';
import 'package:ecommer_user_side/ui/widgets/car_order.dart';
import 'package:ecommer_user_side/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'order_details.dart';

class MyOrders extends StatelessWidget {
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
          'My Order',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            //   child: RaisedButton(onPressed: () async {
            //     await Provider.of<OrderProvider>(context,listen: false)
            //         .getOrder('eTP2TdXSnBYcDhzPJb4U9qMS5Nw1');
            //   }),
            // ),
            child: FutureBuilder<List<OrderModel>>(
              future: Provider.of<OrderProvider>(context).getOrder(
                Provider.of<CardProvider>(context).uId,
              ),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<OrderModel> orderModel = snapshot.data;
                  if (orderModel.length > 0) {
                    return ListView.builder(
                      itemCount: orderModel.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => OrderDetails(
                                  orderModel: orderModel[index1],
                                  indexOrder: index1,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // leading: Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.red, shape: BoxShape.circle),
                              // ),
                              padding: const EdgeInsets.all(15.0),
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.red.withOpacity(0.2),
                                      offset: Offset(3, 2),
                                      blurRadius: 30)
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: orderModel[index1].orderStatus ==
                                              'done'
                                          ? Colors.green
                                          : orderModel[index1].orderStatus ==
                                                  'Proccessing'
                                              ? Colors.yellow
                                              : orderModel[index1]
                                                          .orderStatus ==
                                                      'shipped'
                                                  ? Colors.green[100]
                                                  : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    // child: Card(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Order $index1'),
                                ],
                              ),
                              // children: <Widget>[
                              //   Text('${orderModel[index1].address}'),
                              //   SizedBox(
                              //     height: 200,
                              //     child: ListView.builder(
                              //       itemCount: orderModel[index1].products.length,
                              //       itemBuilder: (BuildContext context, int index) {
                              //         return CardOrder(
                              //           products:
                              //               orderModel[index1].products[index],
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ],
                            ),
                          ),
                        );
                      },
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
          )),
    );
  }
}
