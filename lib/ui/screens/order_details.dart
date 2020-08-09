import 'package:ecommer_user_side/models/orderModel.dart';
import 'package:ecommer_user_side/ui/widgets/car_order.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel orderModel;
  int indexOrder;
  OrderDetails({this.orderModel, this.indexOrder});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Details Order $indexOrder',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Address : '),
                  Text('${orderModel.address}'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text('Status Order : '),
                  Text('${orderModel.orderStatus}'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderModel.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardOrder(
                      products: orderModel.products[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
