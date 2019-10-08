import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/ui/base.dart';
import 'package:uet_comic/src/ui/shared/theme.dart';

class UetComicApp extends StatelessWidget {
  final String title = 'UET comic';
  final List<SingleChildCloneableWidget> providers;
  UetComicApp({this.providers});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: title,
        theme: kUetComicTheme,
        home: BasePage(
          title: title,
        ),
        // initialRoute: Router.Landing,
        // onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
