import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/base.dart';
import 'package:uet_comic/src/ui/views/downloaded.dart';
import 'package:uet_comic/src/ui/views/filter.dart';
import 'package:uet_comic/src/ui/views/followed.dart';
import 'package:uet_comic/src/ui/views/home.dart';
import 'package:uet_comic/src/ui/views/settings.dart';
import 'package:uet_comic/src/ui/widgets/bottom_nav_bar.dart';
import 'package:uet_comic/src/ui/views/search_app_bar.dart';

class BasePage extends StatefulWidget {
  final String title;
  BasePage({Key key, this.title}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final bodyList = <Widget>[
    HomePage(),
    FilterPage(),
    FollowedPage(),
    DownloadedPage(),
  ];

  final items = <BottomNavyBarItem>[
    BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text('Trang chủ'),
      activeColor: Colors.red,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.filter_list),
      title: Text('Lọc truyện'),
      activeColor: Colors.purpleAccent,
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.heart),
      title: Text('Theo dõi'),
      activeColor: Colors.orange,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.folder),
      title: Text('Truyện đã tải'),
      activeColor: Colors.pink,
    ),
  ];

  SearchAppBarDelegate _searchDelegate = SearchAppBarDelegate();

  void showSettingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePageModel>(
      builder: (_, model, __) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                tooltip: 'Tìm kiếm',
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: _searchDelegate,
                  );
                },
              ),
              IconButton(
                tooltip: 'Tài khoản và cài đặt',
                icon: model.accountModel.isLogined == true
                    ?
                    // CircleAvatar(
                    //     radius: 18,
                    //     child: ClipOval(
                    //       child:
                          Image.network(
                            model.accountModel.currentUser.photoUrl,
                        //   ),
                        // ),
                      )
                    : Icon(
                        Icons.account_circle,
                      ),
                onPressed: showSettingPage,
              ),
            ],
          ),
          body: PageView(
            controller: model.pageController,
            onPageChanged: (int index) {
              model.setSelectedIndex(index);
            },
            children: bodyList,
            physics: ClampingScrollPhysics(),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: model.selectedIndex,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: model.slideToPage,
            items: items,
          ),
        );
      },
    );
  }
}
