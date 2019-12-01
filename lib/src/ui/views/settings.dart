import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/user_data.dart';
import 'package:uet_comic/src/core/services/local_file.dart';
import 'package:uet_comic/src/core/services/user_data.dart';
import 'package:uet_comic/src/core/view_models/shared/chapter_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/comic_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/search_dao.dart';
import 'package:uet_comic/src/core/view_models/views/account.dart';
import 'package:uet_comic/src/core/view_models/views/settings.dart';
import 'package:uet_comic/src/ui/views/login.dart';
import 'package:uet_comic/src/ui/widgets/dialogs.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
        // title: Text('Tài khoản và cài đặt'),
      ),
      body: Consumer<SettingsPageModel>(
        builder: (_, model, __) {
          return model.accountModel.isLogined
              ? ListView(
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            leading: const Icon(
                              Icons.account_box,
                              color: Colors.black,
                            ),
                            title: Text('Thông tin tài khoản'),
                          ),
                          ClipOval(
                            child: Image.network(
                              model.accountModel.currentUser.photoUrl,
                            ),
                          ),
                          Center(
                            child: Text(
                              model.accountModel.currentUser.displayName,
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                          FlatButton.icon(
                            icon: Icon(FontAwesomeIcons.signOutAlt),
                            label: Text("Đăng xuất"),
                            onPressed: () {
                              Provider.of<AccountModel>(context).logOut();
                            },
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[..._buildSettings(model)],
                      ),
                    )
                  ],
                )
              : ListView(
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          const ListTile(
                            leading: const Icon(
                              Icons.account_box,
                              color: Colors.black,
                            ),
                            title: Text('Bạn chưa đăng nhập'),
                          ),
                          FlatButton.icon(
                            icon: Icon(FontAwesomeIcons.signInAlt),
                            label: Text("Đăng nhập"),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[..._buildSettings(model)],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  List<Widget> _buildSettings(SettingsPageModel model) {
    return [
      const ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.black,
        ),
        title: Text('Cài đặt'),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            model.accountModel.isLogined ? FlatButton(
              child: Row(
                children: <Widget>[Text("Đồng bộ dữ liệu")],
              ),
              onPressed: () {
                onAsync(model);
              },
            ) : Container(),
            FlatButton(
              child: Row(
                children: <Widget>[Text("Xóa dữ liệu")],
              ),
              onPressed: onDeletes,
            ),
          ],
        ),
      )
    ];
  }

  void onDeletes() async {
    bool confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Confirm(
          header: 'Xóa dữ liệu',
          message: "Bạn muốn các dữ liệu của app?",
          okText: 'Xóa',
          cancelText: 'Hủy',
        );
      },
    );
    if (confirm) {
      List<String> idComics = await Provider.of<ComicDao>(context).removeAll();
      Provider.of<ChapterDao>(context).removeAll();
      for (var i = 0; i < idComics.length; i++) {
        LocalFileService.instance.deleteComicFolder(idComics[i]);
      }
      Provider.of<FollowDao>(context).removeAll();
      Provider.of<LikeDao>(context).removeAll();
      Provider.of<SearchDao>(context).removeAll();
    }
  }

  void onAsync(SettingsPageModel model) async {
    bool confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Confirm(
          header: 'Đồng bộ dữ liệu',
          message: "Bạn muốn đồng bộ dữ liệu từ tài khoản?",
          okText: 'Đồng ý',
          cancelText: 'Hủy',
        );
      },
    );
    if (confirm && model.accountModel.isLogined) {
      UserData userData = await UserDataService.instance
          .fetchUserData(model.accountModel.currentUser.uid);
      if (userData != null) {
        print("userData ${userData.toMap()}");

        Provider.of<LikeDao>(context).setIdLikedComics(userData.likedComics);
        Provider.of<FollowDao>(context)
            .setIdFollowedComics(userData.followedComics);
        Provider.of<SearchDao>(context)
            .setNameSearchedComics(userData.searchedComics);
      }
    }
  }
}
