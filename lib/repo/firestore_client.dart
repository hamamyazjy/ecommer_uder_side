import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommer_user_side/models/cardModel.dart';
import 'package:ecommer_user_side/models/productModel.dart';

class FirestoreClient {
  FirestoreClient._();

  static FirestoreClient firestoreclient = FirestoreClient._();

  setOrdeToFirestore(Map<String, dynamic> map) async {
    try {
      await Firestore.instance.collection('order').add(map);
    } catch (e) {
      print('error' + e);
    }
  }

  Future<QuerySnapshot> getOrderByUserId(String userId) async {
    QuerySnapshot documentSnapshot = await Firestore.instance
        .collection('order')
        .where('userId', isEqualTo: userId)
        .getDocuments();

    return documentSnapshot;
  }

  setLikes(String userId, String productId, Products products) async {
    await Firestore.instance
        .collection('likes')
        .document(userId)
        .setData(products.toJson());
  }

  Future<QuerySnapshot> getProduct() async {
    QuerySnapshot documentSnapshot =
        await Firestore.instance.collection('products').getDocuments();

    return documentSnapshot;
  }

  createCart(Map<String, dynamic> map) async {
    await Firestore.instance.collection('carts').document().setData(map);
  }

  createLikes(CardModel cardModel) async {
    await Firestore.instance.collection('likes').add(cardModel.toJson());
  }

  Future<QuerySnapshot> getAllLikes(String userId) async {
    QuerySnapshot documentSnapshot = await Firestore.instance
        .collection('likes')
        .where('userId', isEqualTo: userId)
        .getDocuments();
    return documentSnapshot;
  }

  deleteCart(String docId) async {
    await Firestore.instance.collection('carts').document(docId).delete();
  }

  deleteLikes(String productName, String userId) async {
    await Firestore.instance
        .collection('likes')
        .where('userId', isEqualTo: userId)
        .where('name', isEqualTo: productName)
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  deleteAllCart() async {
    Firestore.instance.collection('carts').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  Future<QuerySnapshot> getAllCart() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('carts').getDocuments();
    return querySnapshot;
  }

  Future<QuerySnapshot> getProductsByCateory(String category) async {
    QuerySnapshot documentSnapshot = await Firestore.instance
        .collection('products')
        .where('categories', isEqualTo: category)
        .getDocuments();

    return documentSnapshot;
  }

  Future<QuerySnapshot> searchByCateory(String name) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('products')
        .where('categories',
            isGreaterThanOrEqualTo:
                '${name[0].toUpperCase() + name.substring(1)}')
        .where('categories',
            isLessThan: '${name[0].toUpperCase() + name.substring(1)}' + 'z')
        .getDocuments();
    return querySnapshot;
  }

  Future<QuerySnapshot> filterProduct(
      String category, String color, String size, int price) async {
    QuerySnapshot documentSnapshot = await Firestore.instance
        .collection('products')
        .where('categories', whereIn: [category])
        .where('color', isEqualTo: color)
        .where('size', isEqualTo: size)
        .where('price', isEqualTo: price)
        .getDocuments();

    return documentSnapshot;
  }
}
