import 'package:ecommer_user_side/helper/shared_helper.dart';
import 'package:ecommer_user_side/models/orderModel.dart';
import 'package:ecommer_user_side/repo/firebase_repositories.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  String uId;

  getUid() async {
    String uid = await ShaerdHelper.sHelper.getUid();

    this.uId = uid;
  }

  Future<List<OrderModel>> getOrder(String userId) async {
    await getUid();
    List<OrderModel> orderModel =
        await FirebaseRepository.firebaseRepository.getOrderByUserId(userId);

    return orderModel;
  }
}
