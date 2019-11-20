import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uet_comic/src/core/constants/app_contstants.dart';
import 'package:uet_comic/src/core/models/comic.dart';
import 'package:uet_comic/src/ui/shared/type_def.dart';
import 'package:uet_comic/src/ui/widgets/type.dart';

class ComicInfo extends StatelessWidget {
  final Comic comic;
  final VoidCallback read;
  final VoidCallback follow;
  final VoidCallback like;
  final VoidCallback continueRead;
  final StringCallback findComicByType;

  ComicInfo({
    Key key,
    @required this.comic,
    this.read,
    this.follow,
    this.like,
    this.continueRead,
    this.findComicByType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String state = states.firstWhere((e) => e.key == comic.state).value;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comic.name,
            style: Theme.of(context).textTheme.headline,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Text(
            "Tác giả: ${comic?.author?.name}",
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            "Tình trạng: $state",
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: Wrap(
              spacing: 5.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 130,
                  child: RaisedButton.icon(
                    icon: const Icon(Icons.book),
                    label: const Text(
                      "Đọc từ đầu",
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: read,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: RaisedButton.icon(
                    icon: const Icon(FontAwesomeIcons.heart),
                    label: const Text(
                      "Theo dõi",
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: follow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: RaisedButton.icon(
                    icon: const Icon(Icons.thumb_up),
                    label: const Text(
                      "Thích",
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: like,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('Thống kê: '),
              const Icon(Icons.thumb_up),
              Text(' ${comic.like}  '),
              const Icon(FontAwesomeIcons.heart),
              Text(' ${comic.follow}  '),
              const Icon(Icons.remove_red_eye),
              Text(' ${comic.view}')
            ],
          ),
          const SizedBox(height: 8),
          TypeList(
            types: comic.types,
            findComicByType: findComicByType,
          ),
          ExpandablePanel(
            header: const Text(
              "Nội dung truyện",
              overflow: TextOverflow.ellipsis,
            ),
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            collapsed: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                comic.content,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            expanded: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                comic.content,
                softWrap: true,
              ),
            ),
            tapHeaderToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: true,
          )
        ],
      ),
    );
  }
}
