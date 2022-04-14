
import 'package:flutter/foundation.dart';

class JoinOrLogin extends ChangeNotifier{
  bool _isJoin = false;
  bool get isJoin => _isJoin;

  void toggle(){
    _isJoin = !_isJoin;
    notifyListeners();//changenotifierprovider를 통해 데이터를 사용하는 위젯에게 알려줌
  }

}