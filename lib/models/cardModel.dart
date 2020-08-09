import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  String userId;
  String nameProduct;
  String size;
  String color;
  int price;
  String docId;
  String detailsProduct;
  String photoUrl;
  String categories;

  int count;

  CardModel(
      {this.nameProduct,
      this.size,
      this.color,
      this.price,
      this.detailsProduct,
      this.count,
      this.photoUrl,
      this.categories,
      this.userId});

  CardModel.fromJson(Map<String, dynamic> map) {
    this.userId = map['userId'];
    this.nameProduct = map['name'];
    this.size = map['size'];
    this.color = map['color'];
    this.price = map['price'];
    this.count = map['count'];
    this.photoUrl = map['photoProduct'];
    this.detailsProduct = map['detailsProduct'];
    this.categories = map['categories'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'name': this.nameProduct,
      'size': this.size,
      'color': this.color,
      'price': this.price,
      'count': this.count,
      'photoProduct': this.photoUrl,
      'detailsProduct': this.detailsProduct,
      'categories': this.categories,
    };
  }

  CardModel.fromDocument(DocumentSnapshot snapshot) {
    this.docId = snapshot.documentID;
    this.nameProduct = snapshot.data['name'];
    this.size = snapshot.data['size'];
    this.color = snapshot.data['color'];
    this.price = snapshot.data['price'];
    this.count = snapshot.data['count'];
    this.photoUrl = snapshot.data['photoProduct'];

    this.detailsProduct = snapshot.data['detailsProduct'];
    this.categories = snapshot.data['categories'];
  }
}
