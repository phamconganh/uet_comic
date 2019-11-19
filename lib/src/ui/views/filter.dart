import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/models/type.dart' as prefix0;

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<prefix0.Type> types = [prefix0.Type(id: "0", name: "Type 1"), prefix0.Type(id: "1", name: "Type 2333333")];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Thể loại truyện"),
            DropdownButton<String>(
              value: "0",
              items: List.generate(types.length,
                  (index) {
                return DropdownMenuItem(
                  child: Center(
                    child:
                        Text('${types[index].name}'),
                  ),
                  value: types[index].id,
                );
              }),
              onChanged: (String value) {
                // if (value != chapterDetailPageModel.index) {
                //   chapterDetailPageModel.setIndex(value);
                // }
              },
            ),
          ],
        )
      ],
    );
  }
}
