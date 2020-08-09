import 'package:cloud_firestore/cloud_firestore.dart';

import 'cardModel.dart';

class OrderModel {
  List<Map<String, dynamic>> products;

  String address;
  String userId;
  int totalPrice;
  String orderStatus;
  String date;
  OrderModel(
      {this.address,
      this.userId,
      this.products,
      this.totalPrice,
      this.date,
      this.orderStatus});

  OrderModel.fromDocument(DocumentSnapshot snapshot) {
    this.address = snapshot.data['address'];
    this.orderStatus = snapshot.data['orderStatus'];
    this.date = snapshot.data['date'];

    this.userId = snapshot.data['userId'];
    this.totalPrice = snapshot.data['totalPrice'];

    this.products = new List<Map<String, dynamic>>();
    snapshot.data['products'].forEach((v) {
      products.add( CardModel.fromJson(v).toJson());
    });

    print(snapshot.data['products'].runtimeType);
  }

  Map<String, dynamic> toJson() {
    return {
      'orderStatus': this.orderStatus,
      'products': this.products,
      'date': this.date,
      'userId': this.userId,
      'totalPrice': this.totalPrice,
      'address': this.address,
    };
  }
}
