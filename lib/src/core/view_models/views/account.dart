import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/services/authentication.dart';

class AccountModel extends ChangeNotifier {
  AccountModel() {
    loadUser();
  }

  Future loadUser() async {
    setCurrentUser(await AuthenticationService.instance.getUser());
  }

  bool get isLogined => _currentUser != null;

  FirebaseUser _currentUser;
  FirebaseUser get currentUser => _currentUser;
  void setCurrentUser(FirebaseUser user) {
    _currentUser = user;
    notifyListeners();
  }

  logOut() {
    AuthenticationService.instance.logout();
    setCurrentUser(null);
  }
}
