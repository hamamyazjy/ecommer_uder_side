import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommer_user_side/helper/shared_helper.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/orderModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/repo/firebase_repositories.dart';
import 'package:ecommer_user_side/repo/firestore_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<Products> products = [];
  List<Products> products2 = [];
  List<CardModel> productsLike = [];

  List<String> likeListProduct = [];

  List<String> sizes = ['XXL', 'XL', 'L', 'M', 'S'];
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.greenAccent
  ];
  Color selectedColor;
  int colorClick = -1;

  Future<List<Products>> setProducts() async {
    await getUid();
    // await getLikes();
    List<Products> products =
        await FirebaseRepository.firebaseRepository.getProducts();
    notifyListeners();
    this.products = products;
    return products;
  }

  Future<List<CardModel>> setProductsLikes() async {
    // await getUid();

    List<CardModel> productsLike =
        await FirebaseRepository.firebaseRepository.getAllLikes(uId);
    notifyListeners();
    this.productsLike = productsLike;
    return productsLike;
  }

  String selectedNameColor;
  String uId;
  getLikes() async {
    List<String> likeListProduct = await ShaerdHelper.sHelper.getProductsLike();

    this.likeListProduct = likeListProduct;
    notifyListeners();
  }

  getUid() async {
    String uid = await ShaerdHelper.sHelper.getUid();

    this.uId = uid;
    notifyListeners();
  }

  // ProductionCompanies result =
  //         favMovies.singleWhere((element) => element.id == movies.id);

  //     favMovies.removeAt(favMovies.indexOf(result));

  changeLikeProduct(String prName, CardModel cardModel) async {
    await getUid();
    if (likeListProduct.contains(prName)) {
      ShaerdHelper.sHelper.setProductsLike(likeListProduct);

      likeListProduct.remove(prName);

      await FirestoreClient.firestoreclient
          .deleteLikes(cardModel.nameProduct, uId);
      ShaerdHelper.sHelper.setProductsLike(likeListProduct);
    } else {
      likeListProduct.add(prName);
      ShaerdHelper.sHelper.setProductsLike(likeListProduct);
      await FirestoreClient.firestoreclient.createLikes(cardModel);
    }
    notifyListeners();
  }

  changeSeclectedColor(int index) {
    switch (index) {
      case 0:
        colorClick = 0;
        selectedColor = colors[0];
        selectedNameColor = 'Red';
        notifyListeners();

        break;
      case 1:
        colorClick = 1;
        selectedColor = colors[1];
        selectedNameColor = 'green';
        notifyListeners();

        break;
      case 2:
        colorClick = 2;
        selectedColor = colors[2];
        selectedNameColor = 'yellow';
        notifyListeners();

        break;
      case 3:
        colorClick = 3;
        selectedColor = colors[3];
        selectedNameColor = 'black';
        notifyListeners();

        break;
      case 4:
        colorClick = 4;
        selectedColor = colors[4];
        selectedNameColor = 'greenAccent';
        notifyListeners();

        break;
    }
  }

  String selectedSize = 'XL';
  changeSelectedSize(String val) {
    this.selectedSize = val;
    notifyListeners();
  }

  searchProductToCard(String category) async {
    this.products2 =
        await FirebaseRepository.firebaseRepository.searchByCateory(category);
    notifyListeners();
  }

  Future<List<Products>> getProductsByCateory(String cateory) async {
    products = await FirebaseRepository.firebaseRepository
        .getProductsByCateory(cateory);
    notifyListeners();
    return products;
  }
}
