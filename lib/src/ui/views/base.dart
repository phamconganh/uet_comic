import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/views/downloaded.dart';
import 'package:uet_comic/src/ui/views/filter.dart';
import 'package:uet_comic/src/ui/views/followed.dart';
import 'package:uet_comic/src/ui/views/home.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:uet_comic/src/ui/views/settings.dart';
import 'package:uet_comic/src/ui/widgets/bottom_nav_bar.dart';
import 'package:uet_comic/src/ui/views/search_app_bar.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';

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
    _searchDelegate = SearchAppBarDelegate(
      words: kWords,
      history: ['apple', 'orange', 'banana', 'watermelon'],
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Shows Search result
  void showSearchPage(
      BuildContext context, SearchAppBarDelegate searchDelegate) async {
    final String idSelected = await showSearch<String>(
      context: context,
      delegate: searchDelegate,
    );

    if (idSelected != null) {
      // var model = Provider.of<ComicDetailPageModel>(context);
      // model.onLoadData(idSelected);
      // model.setFollow(Provider.of<FollowDao>(context)
      //     .idFollowedComics
      //     .contains(idSelected));
      // model.setLike(
      //     Provider.of<LikeDao>(context).idLikedComics.contains(idSelected));

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => ComicDetailPage(
      //       idComic: idSelected,
      //       part: "search_app_bar",
      //     ),
      //   ),
      // );
      print(idSelected);
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Your Word Choice: $selected'),
      //   ),
      // );
    }
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
              showSearchPage(context, _searchDelegate);
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
