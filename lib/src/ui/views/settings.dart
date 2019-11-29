import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/account.dart';
import 'package:uet_comic/src/core/view_models/views/settings.dart';
import 'package:uet_comic/src/ui/views/login.dart';

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
                    const Divider(),
                    const ListTile(
                      leading: const Icon(
                        Icons.account_box,
                        color: Colors.black,
                      ),
                      title: Text('Thông tin tài khoản'),
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.network(
                          model.accountModel.currentUser.photoUrl,
                        ),
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
                    ..._buildSettings()
                  ],
                )
              : ListView(
                  children: <Widget>[
                    const Divider(),
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
                            builder: (BuildContext context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                    ..._buildSettings()
                  ],
                );
        },
      ),
    );
  }

  List<Widget> _buildSettings() {
    return [
      const ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.black,
        ),
        title: Text('Cài đặt'),
      ),
      
    ];
  }
}
