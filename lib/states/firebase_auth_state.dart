
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/states/user_notifier.dart';

import '../utils/logger.dart';
class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  User? _firebaseUser = null;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void watchAuthChange(){
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if(firebaseUser == null && _firebaseUser == null){
        return;
      }else if(firebaseUser != _firebaseUser){
        _firebaseUser = firebaseUser!;
        changeFirebaseAuthStatus();
      }
    });

  }

  void registerUser(BuildContext context, @required String email,@required String password)async{
    final UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).catchError((Error){
      String _message = "";
      switch(Error.code){
        case 'email-already-in-use':
          _message = "이미 사용중인 이메일 입니다.";
          break;
        case 'invalid-email':
          _message = "유효하지 않은 이메일 입니다.";
          break;
        case 'operation-not-allowed':
          _message = "허용되지 않은 동작입니다.";
          break;
        case 'weak-password':
          _message = "패스워드가 약합니다.";
          break;
      }
      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });
    logger.d(user);
    if(user!=null){
      UserNotifier().initUser();
      SnackBar snackBar = SnackBar(content: Text("회원가입이 완료되었습니다."));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }



  void login(BuildContext context, @required String email,@required String password)async{
    final UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).catchError((Error){
      String _message = "";
      switch(Error.code){
        case 'user-disabled':
          _message = "비활성화된 유저입니다.";
          break;
        case 'invalid-email':
          _message = "유효하지 않은 이메일 입니다.";
          break;
        case 'user-not-found':
          _message = "유저를 찾을 수 없습니다.";
          break;
        case 'wrong-passwordd':
          _message = "패스워드가 틀렸습니다.";
          break;
      }
      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });

    if(user!=null){
      Provider.of<UserNotifier>(context, listen: false).initUser();
      Provider.of<UserNotifier>(context, listen: false).setUserAuth(true);
    }
  }
  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]){
    if(firebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    }else{
      if(_firebaseUser != null){
        _firebaseAuthStatus =FirebaseAuthStatus.signin;
        UserNotifier().setUserAuth(true);
      }else{
        _firebaseAuthStatus =FirebaseAuthStatus.signout;
        UserNotifier().setUserAuth(false);
      }
    }
  }
  @override
  notifyListeners();
}
enum FirebaseAuthStatus{
  signout, progress, signin
}