
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sports_matching/states/user_provider.dart';
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
  void registerUser(@required String email,@required String password){
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
  void login(@required String email,@required String password){
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]){
    if(firebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    }else{
      if(_firebaseUser != null){
        _firebaseAuthStatus =FirebaseAuthStatus.signin;
        UserProvider().setUserAuth(true);
      }else{
        _firebaseAuthStatus =FirebaseAuthStatus.signout;
        UserProvider().setUserAuth(false);
      }
    }
  }
  @override
  notifyListeners();
}
enum FirebaseAuthStatus{
  signout, progress, signin
}