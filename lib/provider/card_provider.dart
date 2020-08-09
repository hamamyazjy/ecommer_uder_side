import 'package:ecommer_user_side/helper/shared_helper.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/orderModel.dart';
import 'package:ecommer_user_side/repo/firebase_repositories.dart';
import 'package:ecommer_user_side/repo/firestore_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  List<CardModel> cards = [];
  int totalPriceAllCard = 0;
  String uId;

  Future<List<CardModel>> setCards() async {
    List<CardModel> cards =
        await FirebaseRepository.firebaseRepository.getAllCart();
    // if (cards.length == 0) {
    // totalPriceAllCard = 0;
    // } else {
    // await getToTalPriceAllCardProduct();
    // }
    notifyListeners();
    this.cards = cards;

    return cards;
  }

  // setCards1() async {}

  addCartToFireBase(CardModel cardModel) async {
    // totalPriceAllCard = 0;
    await FirestoreClient.firestoreclient.createCart(cardModel.toJson());

    await getToTalPriceAllCardProduct();
    await setCards();
  }

  getToTalPriceAllCardProduct() async {
    totalPriceAllCard = 0;
    List<CardModel> cards =
        await FirebaseRepository.firebaseRepository.getAllCart();
    // int total = 0;
    for (var i = 0; i < cards.length; i++) {
      this.totalPriceAllCard += (cards[i].price * cards[i].count);
    }
    // this.totalPriceAllCard = total;
    print(totalPriceAllCard);
    notifyListeners();
  }

  getUid() async {
    String uid = await ShaerdHelper.sHelper.getUid();

    this.uId = uid;
  }

  deleteAllProductFormSqlAndAddToOrderFireStore(String address) async {
    await getUid();

    // String  address={'',''};

    // List<CardModel> cards = await DbCardRepository.dbRepository.getAllProduct();
    List<Map<String, dynamic>> products = cards.map((e) => e.toJson()).toList();
    DateTime date = DateTime.now();
    OrderModel order = OrderModel(
      userId: uId,
      date: '${date.year}: ${date.month}: ${date.day}'.toString(),
      orderStatus: 'Proccessing',
      totalPrice: totalPriceAllCard,
      address: address,
      products: products,
    );

    await FirebaseRepository.firebaseRepository.setOrderoFirestore(order);

    // await deleteAllProduct();
    await FirestoreClient.firestoreclient.deleteAllCart();
    totalPriceAllCard = 0;

    notifyListeners();
  }

  deleteCart(String docId) async {
    await FirestoreClient.firestoreclient.deleteCart(docId);

    await getToTalPriceAllCardProduct();
    await setCards();
  }
}
