import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuthState extends ChangeNotifier {
  AppAuthState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  User? loginUser;
  String getUserID(){
    if(loginUser!=null){
      return loginUser!.uid;
    }
    throw('No Login User');
  }

  Future<void> init() async {

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        loginUser = user;
      } else {
        _loggedIn = false;
        loginUser = null;
      }
      notifyListeners();
    });
  }
}
