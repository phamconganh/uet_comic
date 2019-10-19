import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChapterList extends StatelessWidget {

  final String idComic;

  ChapterList({Key key, this.idComic}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    return ListView.separated(

      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 30,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Chuong ${index}"),
              Text("18/10/2019"),
            ],
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      // children: List.generate(3, (index) {

      // })
    );
  }
}
