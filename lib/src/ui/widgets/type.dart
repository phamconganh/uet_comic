import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uet_comic/src/core/models/type.dart' as uet_comic_type;
import 'package:uet_comic/src/ui/shared/type_def.dart';

class TypeList extends StatelessWidget {
  final List<uet_comic_type.Type> types;
  final StringCallback findComicByType;

  TypeList({Key key, @required this.types, this.findComicByType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3.0,
      children: List.generate(
        types.length,
        (index) => RaisedButton(
          child: Text(
            types[index].name,
          ),
          onPressed: () {
            if (findComicByType != null) findComicByType(types[index].id);
          },
        ),
      ),
    );
  }
}
