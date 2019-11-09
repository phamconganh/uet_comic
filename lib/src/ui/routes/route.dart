// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:uet_comic/src/core/constants/app_contstants.dart';
// import 'package:uet_comic/src/core/models/chapter.dart';
// import 'package:uet_comic/src/core/models/comic.dart';
// import 'package:uet_comic/src/ui/views/base.dart';
// import 'package:uet_comic/src/ui/views/chapter_detail.dart';
// import 'package:uet_comic/src/ui/views/comic_detail.dart';
// import 'package:uet_comic/src/ui/views/login.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case RoutePaths.Base:
//       return MaterialPageRoute(builder: (_) => BasePage());
//     case RoutePaths.Login:
//       return MaterialPageRoute(builder: (_) => LoginPage());
//     case RoutePaths.Comic:
//       String idComic = settings.arguments as String;
//       return MaterialPageRoute(
//         builder: (_) => ComicDetailPage(
//           idComic: idComic,
//         ),
//       );
//     case RoutePaths.Chapter:
//       int indexChapter = settings.arguments as int;
//       List<Chapter> chapters = settings.arguments as List<Chapter> ;
//       Comic comic = settings.arguments as Comic;
//       return MaterialPageRoute(
//         builder: (_) => ChapterDetailPage(
//           chapters: chapters,
//           indexChapter: indexChapter,
//           comic: comic,
//         ),
//       );
//     default:
//       return MaterialPageRoute(
//         builder: (_) => Scaffold(
//           body: Center(
//             child: Text('No route defined for ${settings.name}'),
//           ),
//         ),
//       );
//   }
// }
