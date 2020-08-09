import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommer_user_side/repo/firebase_repositories.dart';
import 'package:ecommer_user_side/models/productModel.dart';

class FilterProvider extends ChangeNotifier {
  int price = 200;

  Color selectedColor;
  String selectedNameColor;
  String selectedCategories = 'Men';
  String selectedSize = 'XL';

  String url;
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.greenAccent
  ];

  List<String> categories = ['Men', 'Women', 'Baby'];
  List<String> sizes = ['XXL', 'XL', 'L', 'M', 'S'];

  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  changeSelectedSize(String val) {
    this.selectedSize = val;
    notifyListeners();
  }

  changeSelectedCategories(String val) {
    this.selectedCategories = val;
    notifyListeners();
  }

  changePrice(double value) {
    this.price = value.toInt();
    notifyListeners();
  }

  changeSeclectedColor(int index) {
    switch (index) {
      case 0:
        selectedColor = colors[0];
        selectedNameColor = 'Red';
        notifyListeners();

        break;
      case 1:
        selectedColor = colors[1];
        selectedNameColor = 'green';
        notifyListeners();

        break;
      case 2:
        selectedColor = colors[2];
        selectedNameColor = 'yellow';
        notifyListeners();

        break;
      case 3:
        selectedColor = colors[3];
        selectedNameColor = 'black';
        notifyListeners();

        break;
      case 4:
        selectedColor = colors[4];
        selectedNameColor = 'greenAccent';
        notifyListeners();

        break;
    }
  }

  Future<List<Products>> filterProduxts() async {
    List<Products> products = await FirebaseRepository.firebaseRepository
        .filterProduct(
            selectedCategories, selectedNameColor, selectedSize, price);
    print(products.length);
    return products;
    // notifyListeners();
  }

  cleanFilter() async {
    this.price = 200;
    selectedNameColor = '';
    selectedCategories = 'Men';
    selectedSize = 'XL';
    notifyListeners();
  }
}
