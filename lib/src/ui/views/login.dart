import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/constants/app_contstants.dart';
import 'package:uet_comic/src/core/models/user_data.dart';
import 'package:uet_comic/src/core/services/authentication.dart';
import 'package:uet_comic/src/core/services/user_data.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/search_dao.dart';
import 'package:uet_comic/src/core/view_models/views/account.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/ui/widgets/dialogs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AccountModel accountModel;
  BasePageModel basePageModel;
  LikeDao likeDao;
  FollowDao followDao;
  SearchDao searchDao;

  @override
  Widget build(BuildContext context) {
    if (accountModel == null) {
      accountModel = Provider.of(context);
    }
    if (searchDao == null) {
      searchDao = Provider.of(context);
    }
    if (likeDao == null) {
      likeDao = Provider.of(context);
    }
    if (followDao == null) {
      followDao = Provider.of(context);
    }
    if (basePageModel == null) {
      basePageModel = Provider.of(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Image.asset("assets/icon.png"),
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    child: GoogleSignInButton(
                      text: 'Đăng nhập với google',
                      onPressed: () {
                        login(TypeLogin.GG);
                      },
                    ),
                    width: 259,
                  ),
                  SizedBox(
                    child: FacebookSignInButton(
                      text: 'Đăng nhập với facebook',
                      onPressed: () {
                        login(TypeLogin.FB);
                      },
                    ),
                    width: 259,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void login(TypeLogin type) async {
    StatusLogin result;
    if (type == TypeLogin.GG) {
      result = await AuthenticationService.instance.loginGoogle();
    } else {
      result = await AuthenticationService.instance.loginFacebook();
    }
    if (result == StatusLogin.SUCCESS) {
      await accountModel.loadUser();
      basePageModel.slideToPage(0);
      Navigator.popUntil(context, ModalRoute.withName('/'));

      UserData userData = await UserDataService.instance
          .fetchUserData(accountModel.currentUser.uid);
      if (userData != null) {
        print("userData ${userData.toMap()}");

        likeDao.setIdLikedComics(userData.likedComics);
        followDao.setIdFollowedComics(userData.followedComics);
        searchDao.setNameSearchedComics(userData.searchedComics);
      }
    } else if (result == StatusLogin.ERROR && type == TypeLogin.FB) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Notify(
            header: 'Lỗi trong quá trình đăng nhập',
            message:
                'Đã xảy ra lỗi trong quá trình đăng nhập. Xin hãy kiểm tra đường truyền mạng hoặc tài khoản',
          );
        },
      );
    }
  }
}
