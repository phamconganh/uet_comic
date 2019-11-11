// import 'package:sembast/sembast.dart';
// import 'package:uet_comic/src/core/models/comic.dart';
// import 'package:uet_comic/src/core/services/local.dart';

// class ComicLocalService {
//   static const String COMIC_STORE_NAME = 'comic';
//   // A Store with int keys and Map<String, dynamic> values.
//   // This Store acts like a persistent map, values of which are Fruit objects converted to Map
//   final _comicStore = intMapStoreFactory.store(COMIC_STORE_NAME);

//   // Private getter to shorten the amount of code needed to get the
//   // singleton instance of an opened database.
//   Future<Database> get _db async => await LocalService.instance.database;

//   // Future insert(Fruit fruit) async {
//   //   await _comicStore.add(await _db, fruit.toMap());
//   // }

//   // Future update(Fruit fruit) async {
//   //   // For filtering by key (ID), RegEx, greater than, and many other criteria,
//   //   // we use a Finder.
//   //   final finder = Finder(filter: Filter.byKey(fruit.id));
//   //   await _comicStore.update(
//   //     await _db,
//   //     fruit.toMap(),
//   //     finder: finder,
//   //   );
//   // }

//   // Future delete(Fruit fruit) async {
//   //   final finder = Finder(filter: Filter.byKey(fruit.id));
//   //   await _comicStore.delete(
//   //     await _db,
//   //     finder: finder,
//   //   );
//   // }

//   Future<List<Comic>> getAllSortedByName() async {
//     // Finder object can also sort data.
//     final finder = Finder(sortOrders: [
//       SortOrder('name'),
//     ]);

//     final recordSnapshots = await _comicStore.find(
//       await _db,
//       finder: finder,
//     );

//     // Making a List<Fruit> out of List<RecordSnapshot>
//     return recordSnapshots.map((snapshot) {
//       final fruit = Comic.fromMap(snapshot.value);
//       // An ID is a key of a record from the database.
//       fruit.id = snapshot.key;
//       return fruit;
//     }).toList();
//   }
// }