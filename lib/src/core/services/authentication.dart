// import 'dart:async';
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// // import 'package:hoclieu_mobile/core/models/user.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// class AuthenticationService {

//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User _currentUser;
//   String _token;

//   User get currentUser => _currentUser;
//   String get token => _token;

//   bool get isLogged => (_currentUser == null) ? false : true;

//   Future _loginOnServer(String accessToken, String network) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, dynamic> body = {'access_token': accessToken};

//     var res = await _api.postClient("api/users/$network", body: body);

//     if (res["code"] == 1) {
//       _currentUser = User.fromJson(res["data"]["user"]);
//       _token = res["data"]["token"];
//       await prefs.setString("currentUser", json.encode(res["data"]["user"]));
//       await prefs.setString("token", res["data"]["token"]);
//     }
//   }

//   Future loginFacebook() async {
//     FacebookLogin facebookLogin = FacebookLogin();
//     FacebookLoginResult facebookLoginResult =
//         await facebookLogin.logInWithReadPermissions(['email']);
//     switch (facebookLoginResult.status) {
//       case FacebookLoginStatus.error:
//         print("error");
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         print("cancelledByUser");
//         break;
//       case FacebookLoginStatus.loggedIn:
//         String accessToken = facebookLoginResult.accessToken.token;
//         await _loginOnServer(accessToken, 'facebook');
//         break;
//     }
//   }

//   Future loginGoogle() async {
//     final GoogleSignIn _googleSignIn = GoogleSignIn(
//       scopes: ['email', 'profile'],
//     );
//     await _googleSignIn.signOut();
//     GoogleSignInAccount googleLoginResult = await _googleSignIn.signIn();
//     if (googleLoginResult != null) {
//       GoogleSignInAuthentication googleKey =
//           await googleLoginResult.authentication;
//       String accessToken = googleKey.accessToken;
//       await _loginOnServer(accessToken, 'google');
//     }
//   }

//   Future logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     _currentUser = null;
//     _token = null;
//     await prefs.clear();
//   }

//   Future initUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String strCurrentUser = prefs.getString("currentUser");
//     if (strCurrentUser != null && strCurrentUser.isNotEmpty) {
//       _currentUser = User.fromJson(json.decode(strCurrentUser));
//       _token = prefs.getString("token");
//     }
//   }
// }
