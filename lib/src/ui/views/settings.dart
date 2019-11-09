import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản và cài đặt'),
      ),
      body: ListView(
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
            backgroundColor: Colors.brown.shade800,
            child: Text('AH'),
          ),
          const Divider(),
          const ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text('Cài đặt'),
          ),
        ],
      ),
    );
  }
}
