import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/view_models/views/search_app_bar.dart';

class SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> words;
  final List<String> history;

  SearchAppBarDelegate({this.words, this.history});

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

    // return Column(
    //   children: <Widget>[
    //     ComicCoverList(
    //       comicCovers: model.followedComics,
    //       choosedComic: choosedComic,
    //       part: "Truyện đã theo dõi",
    //     ),
    //   ],
    // );
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('===Your Word Choice==='),
            GestureDetector(
              onTap: () {
                //Define your action when clicking on result item.
                //In this example, it simply closes the page
                close(context, query);
              },
              child: Text(
                query,
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions =
        query.isEmpty ? history : words.where((word) => word.startsWith(query));

    return _WordsSuggestionWidget(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        history.insert(0, suggestion);
            SearchAppBarModel model = Provider.of(context);
    model.searchComics("Nguyet Thuong");
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
      // IconButton(
      //     icon: Icon(Icons.mic),
      //     tooltip: 'Voice input',
      //     onPressed: () {
      //       query = 'TBW: Get input from voice';
      //     },
      //   ),
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
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
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
