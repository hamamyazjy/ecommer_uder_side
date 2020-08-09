import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String id;
  String nameProduct;
  String size;
  String color;
  int price;
  String docId;
  String detailsProduct;
  String photoUrl;
  String categories;

  Products(
      {this.nameProduct,
      this.size,
      this.color,
      this.price,
      this.detailsProduct,
      this.photoUrl,
      this.categories});

  Products.fromDocument(DocumentSnapshot map) {
    this.id = map.documentID;
    this.nameProduct = map.data['name'];
    this.size = map.data['size'];
    this.color = map.data['color'];
    this.price = map.data['price'];
    this.photoUrl = map.data['photoProduct'];
    this.detailsProduct = map.data['detailsProduct'];
    this.categories = map.data['categories'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.nameProduct,
      'size': this.size,
      'color': this.color,
      'price': this.price,
      'photoProduct': this.photoUrl,
      'detailsProduct': this.detailsProduct,
      'categories': this.categories,
    };
  }

  Products.fromJson(Map<String, dynamic> map) {
    this.nameProduct = map['name'];
    this.size = map['size'];
    this.color = map['color'];
    this.price = map['price'];
    this.photoUrl = map['photoProduct'];
    this.detailsProduct = map['detailsProduct'];
    this.categories = map['categories'];
  }
}
