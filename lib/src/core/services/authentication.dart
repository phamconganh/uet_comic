import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uet_comic/src/core/constants/app_contstants.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthenticationService {
  static final AuthenticationService instance =
      AuthenticationService.internal();
  AuthenticationService.internal();
  factory AuthenticationService() => instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email']);
  final FacebookLogin _facebookLogin = FacebookLogin();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<StatusLogin> loginFacebook() async {
    FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
    print("Status login fb: ${facebookLoginResult.status}");
    final accessToken = facebookLoginResult.accessToken.token;
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        return StatusLogin.CANCEL;
        break;
      case FacebookLoginStatus.error:
        return StatusLogin.ERROR;
        break;
      case FacebookLoginStatus.loggedIn:
        final facebookAuthCred =
            FacebookAuthProvider.getCredential(accessToken: accessToken);
        await _auth.signInWithCredential(facebookAuthCred);
        return StatusLogin.SUCCESS;
        break;
      default:
        return StatusLogin.CANCEL;
        break;
    }
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn(['email']);
    return facebookLoginResult;
  }

  Future<StatusLogin> loginGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
      final googleAuth = await googleSignInAccount.authentication;
      final googleAuthCred = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _auth.signInWithCredential(googleAuthCred);
      return StatusLogin.SUCCESS;
    } catch (error) {
      return StatusLogin.ERROR;
    }
  }

  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    return googleSignInAccount;
  }

  logout() async {
    await _auth.signOut();
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
}
