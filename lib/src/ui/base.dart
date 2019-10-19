// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uet_comic/src/core/services/api.dart';
// import 'package:uet_comic/src/ui/views/account.dart';
import 'package:uet_comic/src/ui/views/downloaded.dart';
import 'package:uet_comic/src/ui/views/home.dart';
import 'package:uet_comic/src/ui/views/search.dart';
// import 'package:uet_comic/src/ui/views/settings.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:uet_comic/src/ui/widgets/bottom_nav_bar.dart';
import 'package:uet_comic/src/ui/widgets/search_app_bar.dart';

class BasePage extends StatefulWidget {
  final String title;
  BasePage({Key key, this.title}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;

  // bool _showAppbar = true; //this is to show app bar
  // ScrollController _scrollBottomBarController = ScrollController(); // set controller on scrolling
  // bool isScrollingDown = false;
  // bool _show = true;

  final pageController = PageController();
  final bodyList = <Widget>[
    HomePage(),
    SearchPage(),
    DownloadedPage(),
  ];

  final items = <BottomNavyBarItem>[
    BottomNavyBarItem(
      icon: Icon(Icons.apps),
      title: Text('Home'),
      activeColor: Colors.red,
    ),
    BottomNavyBarItem(
        icon: Icon(Icons.search),
        title: Text('Search'),
        activeColor: Colors.purpleAccent),
    BottomNavyBarItem(
        icon: Icon(Icons.folder),
        title: Text('Downloaded'),
        activeColor: Colors.pink),
  ];

  final List<String> kWords;
  SearchAppBarDelegate _searchDelegate;

  //Initializing with sorted list of english words
  _BasePageState()
      : kWords = List.from(Set.from(words.all))
          ..sort(
            (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
          ),
        super();

  @override
  void initState() {
    super.initState();
    // scrollToHide();
    //Initializing search delegate with sorted list of English words
    _searchDelegate = SearchAppBarDelegate(kWords);
  }

  // @override
  // void dispose() {
  //   _scrollBottomBarController.removeListener(() {});
  //   super.dispose();
  // }

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); // ADD THIS LINE

  // void scrollToHide() async {
  //   _scrollBottomBarController.addListener(() {
  //     if (_scrollBottomBarController.position.userScrollDirection == ScrollDirection.reverse && !isScrollingDown) {
  //       isScrollingDown = true;
  //       _showAppbar = false;
  //       hideBottomBar();
  //     }
  //     if (_scrollBottomBarController.position.userScrollDirection == ScrollDirection.forward && isScrollingDown) {
  //       isScrollingDown = false;
  //       _showAppbar = true;
  //       showBottomBar();
  //     }
  //   });
  // }

  // void showBottomBar() {
  //   setState(() {
  //     _show = true;
  //   });
  // }

  // void hideBottomBar() {
  //   setState(() {
  //     _show = false;
  //   });
  // }

  // void _onTap(int index) {
  //   pageController.jumpToPage(index);
  //   // _scaffoldKey.currentState.openDrawer();
  // }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Shows Search result
  void showSearchPage(
      BuildContext context, SearchAppBarDelegate searchDelegate) async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: searchDelegate,
    );

    if (selected != null) {
      print(selected);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Word Choice: $selected'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.title),
          actions: <Widget>[
            //Adding the search widget in AppBar
            IconButton(
              tooltip: 'Search',
              icon: Icon(
                Icons.search,
              ),
              //Don't block the main thread
              onPressed: () {
                showSearchPage(context, _searchDelegate);
              },
            ),
            IconButton(
              tooltip: 'Account and Settings',
              icon: Icon(
                Icons.account_circle,
              ),
              //Don't block the main thread
              onPressed: () {
                // showSearchPage(context, _searchDelegate);
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList,
        physics: ClampingScrollPhysics(),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0), // here the desired height
        child: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: items,
          height: 45.0,
        ),
      ),
    );
  }
}
