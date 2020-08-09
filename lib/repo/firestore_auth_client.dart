import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommer_user_side/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAuth {
  FirestoreAuth._();

  static FirestoreAuth firestoreAuth = FirestoreAuth._();

  setUserToFirestore(FirebaseUser user, Map<String, dynamic> map) async {
    await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .setData(map);
  }

  updateUser(String uId, UserModel userModel) async {
    await Firestore.instance
        .collection('Users')
        .document(uId)
        .updateData(userModel.toJson());
  }

  // Future<DocumentSnapshot> getUser(String uId) async {
  //   DocumentSnapshot documentSnapshot =
  //       await Firestore.instance.collection('Users').document(uId).get();
  //   return documentSnapshot;
  // }

  Future<DocumentSnapshot> getUser(FirebaseUser user) async {
    DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection('Users').document(user.uid).get();

    return documentSnapshot;
  }
}
