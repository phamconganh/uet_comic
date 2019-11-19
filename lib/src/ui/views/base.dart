import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  int _selectedIndex = 0;

  final pageController = PageController();
  final bodyList = <Widget>[
    HomePage(),
    FilterPage(),
    FollowedPage(),
    DownloadedPage(),
  ];

  final items = <BottomNavyBarItem>[
    BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
      activeColor: Colors.red,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.filter_list),
      title: Text('Search'),
      activeColor: Colors.purpleAccent,
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.heart),
      title: Text('Followed'),
      activeColor: Colors.orange,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.folder),
      title: Text('Downloaded'),
      activeColor: Colors.pink,
    ),
  ];

  SearchAppBarDelegate _searchDelegate = SearchAppBarDelegate();

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void showSettingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
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
            tooltip: 'Account and Settings',
            icon: Icon(
              Icons.account_circle,
            ),
            onPressed: showSettingPage,
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList,
        physics: ClampingScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: items,
      ),
    );
  }
}
