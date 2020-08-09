import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/orderModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';

import 'firestore_client.dart';

class FirebaseRepository {
  FirebaseRepository._();

  static FirebaseRepository firebaseRepository = FirebaseRepository._();
// FirebaseUser user,
  // setCardToFirestore(CardModel cardModel) async {
  //   await FirestoreClient.firestoreclient
  //       .setCardToFirestore(cardModel.toJson());
  // }

//  Future<List<CardModel>> getCard() async {
//     QuerySnapshot querySnapshot =
//         await FirestoreClient.firestoreclient.getCard();
//     List<CardModel> cardModel =
//         querySnapshot.documents.map((e) => CardModel.fromDocument(e)).toList();

//     return cardModel;
//   }

  setOrderoFirestore(OrderModel order) async {
    await FirestoreClient.firestoreclient.setOrdeToFirestore(order.toJson());
  }

  Future<List<OrderModel>> getOrderByUserId(String userId) async {
    QuerySnapshot querySnapshot =
        await FirestoreClient.firestoreclient.getOrderByUserId(userId);
    List<OrderModel> orderModel =
        querySnapshot.documents.map((e) => OrderModel.fromDocument(e)).toList();

    return orderModel;
  }

  Future<List<Products>> searchByCateory(String category) async {
    QuerySnapshot querySnapshot =
        await FirestoreClient.firestoreclient.searchByCateory(category);
    List<Products> products =
        querySnapshot.documents.map((e) => Products.fromDocument(e)).toList();

    return products;
  }

  Future<List<CardModel>> getAllCart() async {
    QuerySnapshot querySnapshot =
        await FirestoreClient.firestoreclient.getAllCart();
    List<CardModel> cards =
        querySnapshot.documents.map((e) => CardModel.fromDocument(e)).toList();

    return cards;
  }

  Future<List<Products>> getProducts() async {
    QuerySnapshot querySnapshot =
        await FirestoreClient.firestoreclient.getProduct();
    List<Products> cardModel =
        querySnapshot.documents.map((e) => Products.fromDocument(e)).toList();

    return cardModel;
  }

  Future<List<Products>> getProductsByCateory(String userId) async {
    QuerySnapshot querySnapshot =
        await FirestoreClient.firestoreclient.getProductsByCateory(userId);
    List<Products> cardModel =
        querySnapshot.documents.map((e) => Products.fromDocument(e)).toList();

    return cardModel;
  }

  Future<List<Products>> filterProduct(
      String category, String color, String size, int price) async {
    QuerySnapshot querySnapshot = await FirestoreClient.firestoreclient
        .filterProduct(category, color, size, price);

    List<Products> products =
        querySnapshot.documents.map((e) => Products.fromDocument(e)).toList();

    return products;
  }

  Future<List<CardModel>> getAllLikes(String userId) async {
    QuerySnapshot querySnapshot =
        await FirestoreClient.firestoreclient.getAllLikes(userId);
    List<CardModel> cardModel =
        querySnapshot.documents.map((e) => CardModel.fromDocument(e)).toList();

    return cardModel;
  }
}
