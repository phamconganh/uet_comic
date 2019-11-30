import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/models/search.dart';
import 'package:uet_comic/src/core/services/comic.dart';
import 'package:uet_comic/src/core/services/search.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/search_dao.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class SearchAppBarDelegate extends SearchDelegate<String> {
  SearchAppBarDelegate();

  @override
  String get searchFieldLabel => 'Tìm kiếm tên truyện';

  // Setting leading icon for the search bar.
  // Clicking on back arrow will take control to main page
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        close(context, null);
      },
    );
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    // can chinh lai provider
    return FutureBuilder<List<ComicCover>>(
      future: ComicService.instance.fetchComicCoversByName(query.toLowerCase()),
      builder:
          (BuildContext context, AsyncSnapshot<List<ComicCover>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return ListTile(
              leading: Icon(Icons.search),
              title: Text('Press button to start.'),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return ListTile(
                leading: Icon(Icons.error),
                title: Text('Lỗi mạng!'),
              );
            return ListView(
              children: <Widget>[
                const Divider(),
                snapshot.data.isNotEmpty
                    ? ComicCoverList(
                        comicCovers: snapshot.data,
                        onChoosedComic: (ComicCover comicCover, String part) {
                          var model =
                              Provider.of<ComicDetailPageModel>(context);
                          model.onLoadData(comicCover.id);
                          model.setFollow(Provider.of<FollowDao>(context)
                              .idFollowedComics
                              .contains(comicCover.id));
                          model.setLike(Provider.of<LikeDao>(context)
                              .idLikedComics
                              .contains(comicCover.id));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ComicDetailPage(
                                part: part,
                              ),
                            ),
                          );
                        },
                        part: "searh_app_bar",
                      )
                    : ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Không tìm thấy truyện'),
                      ),
              ],
            );
        }
        return null; // unreachable
      },
    );
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final SearchDao searchDao = Provider.of(context);
    final List<String> history = searchDao.nameSearchedComics;

    if (query.isEmpty) {
      return _buildSuggestions(history, searchDao, context);
    } else {
      return StreamBuilder<QuerySnapshot>(
        stream: SearchService.instance.searchNameComics(query.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return ListTile(
              leading: Icon(Icons.error),
              title: Text('Lỗi mạng!'),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return ListTile(
                leading: Icon(Icons.search),
                title: Text('Loading ...'),
              );
            default:
              List<String> suggestions = snapshot.data.documents
                  .map((e) => Search.fromMap(e.data).name)
                  .toList();
              return _buildSuggestions(suggestions, searchDao, context);
          }
        },
      );
    }
  }

  Widget _buildSuggestions(
      List<String> suggestions, SearchDao searchDao, BuildContext context) {
    return _WordsSuggestionWidget(
      query: query,
      suggestions: suggestions,
      onSelected: (String suggestion) {
        query = suggestion;
        searchDao.add(query);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : Container(),
    ];
  }
}

class _WordsSuggestionWidget extends StatelessWidget {
  _WordsSuggestionWidget({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(Icons.search),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
