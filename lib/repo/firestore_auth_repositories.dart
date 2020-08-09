import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommer_user_side/models/user_model.dart';
import 'package:ecommer_user_side/repo/firestore_auth_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepositoryAuth {
  FirebaseRepositoryAuth._();

  static FirebaseRepositoryAuth firebaseRepository = FirebaseRepositoryAuth._();

  setUserToFirestore(FirebaseUser user, UserModel userModel) async {
    await FirestoreAuth.firestoreAuth
        .setUserToFirestore(user, userModel.toJson());
  }

  Future<UserModel> getUser(FirebaseUser user) async {
    DocumentSnapshot documentSnapshot =
        await FirestoreAuth.firestoreAuth.getUser(user);
    UserModel listQuerySnapshot = UserModel.formJson(documentSnapshot);

    return listQuerySnapshot;
  }
}
