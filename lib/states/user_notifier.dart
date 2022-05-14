import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_matching/repo/user_service.dart';
import '../constants/shared_pref_keys.dart';
import '../data/user_model.dart';
import '../utils/logger.dart';
//유저가 로그인이 되었는가?
class UserNotifier extends ChangeNotifier{
  bool _userLoggedIn = true;

  void setUserAuth(bool authState){
    _userLoggedIn = authState;
    notifyListeners();
  }
  User? _user;
  UserModel? _userModel;
  void initUser(){
    FirebaseAuth.instance.authStateChanges().listen((user) async{
      // _user = user;
      // logger.d('user state - $user');
      await _setNewUser(user);
      notifyListeners();
    });
  }
  Future _setNewUser(User? user) async{
    _user = user;
    if(user != null){
      SharedPreferences prefs = await  SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String email = user.email!;
      String userKey = user.uid;

      UserModel userModel = UserModel(
          createdDate: DateTime.now().toUtc(),
          geoFirePoint: GeoFirePoint(lat, lon),
          userMannerScore: 0.0,
          userRank: "0",
          userKey: "",
          address: address,
          email: email);
      await UserService().createNewUser(userModel.toJson(), userKey);
      _userModel = await UserService().getUserModel(userKey);
      logger.d(_userModel!.toJson().toString());
    }
  }

  bool get userState{
    return _userLoggedIn;
  }
}