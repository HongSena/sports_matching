import 'package:flutter/widgets.dart';
//유저가 로그인이 되었는가?
class UserProvider extends ChangeNotifier{
  bool _userLoggedIn = true;

  void setUserAuth(bool authState){
    _userLoggedIn = authState;
    notifyListeners();
  }

  bool get userState{
    return _userLoggedIn;
  }
}