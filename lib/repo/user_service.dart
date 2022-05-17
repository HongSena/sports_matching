import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports_matching/utils/logger.dart';

import '../constants/data_keys.dart';
import '../data/user_model.dart';

class UserService{

  static final UserService _userService = UserService._internal();
  factory UserService() => _userService;
  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    logger.d(documentSnapshot.data().toString());
    if (!documentSnapshot.exists) {
      await documentReference.set(json);
    }
  }

  Future<UserModel> getUserModel(String userKey) async{
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    UserModel userModel = UserModel.fromSnapShot(documentSnapshot);

    return userModel;
  }

}