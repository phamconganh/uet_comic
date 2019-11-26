import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthenticationService {
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //     scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  // final FacebookLogin _facebookLogin = FacebookLogin();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future loginFacebook() async {
  //   // var user = await _auth.currentUser();
  //   FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
  //   final accessToken = facebookLoginResult.accessToken.token;
  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.cancelledByUser:
  //       return 2;
  //       break;
  //     case FacebookLoginStatus.error:
  //       return 0;
  //       break;
  //     case FacebookLoginStatus.loggedIn:
  //       final facebookAuthCred =
  //           FacebookAuthProvider.getCredential(accessToken: accessToken);
  //       await _auth.signInWithCredential(facebookAuthCred);
  //       return 1;
  //       break;
  //   }
  // }

  // Future<FacebookLoginResult> _handleFBSignIn() async {
  //   FacebookLoginResult facebookLoginResult =
  //       await _facebookLogin.logIn(['email']);
  //   return facebookLoginResult;
  // }

  // Future loginGoogle() async {
  //   try {
  //     GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
  //     final googleAuth = await googleSignInAccount.authentication;
  //     final googleAuthCred = GoogleAuthProvider.getCredential(
  //         idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  //     await _auth.signInWithCredential(googleAuthCred);
  //     return 1;
  //   } catch (error) {
  //     return 0;
  //   }
  // }

  // Future<GoogleSignInAccount> _handleGoogleSignIn() async {
  //   GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //   return googleSignInAccount;
  // }

  Future logout() async {
    await _auth.signOut();
  }
}
