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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GoogleSignInButton(
                text: 'Đăng nhập với google',
                onPressed: () {
                  login(TypeLogin.GG);
                },
              ),
              FacebookSignInButton(
                text: 'Đăng nhập với facebook',
                onPressed: () {
                  login(TypeLogin.FB);
                },
              )
            ],
          ),
        ),
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
      AccountModel accountModel = Provider.of(context);
      await accountModel.loadUser();
      Provider.of<BasePageModel>(context).slideToPage(0);
      Navigator.popUntil(context, ModalRoute.withName('/'));
      UserData userData = await UserDataService.instance
          .fetchUserData(accountModel.currentUser.uid);
      if (userData != null) {
        Provider.of<LikeDao>(context).setIdLikedComics(userData.searchedComics);
        Provider.of<FollowDao>(context)
            .setIdFollowedComics(userData.searchedComics);
        Provider.of<SearchDao>(context)
            .setNameSearchedComics(userData.searchedComics);
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
