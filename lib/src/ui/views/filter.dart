import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uet_comic/src/core/constants/app_contstants.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';
import 'package:uet_comic/src/core/view_models/shared/follow_dao.dart';
import 'package:uet_comic/src/core/view_models/shared/like_dow.dart';
import 'package:uet_comic/src/core/view_models/views/comic_detail.dart';
import 'package:uet_comic/src/core/view_models/views/filter.dart';
import 'package:uet_comic/src/ui/views/comic_detail.dart';
import 'package:uet_comic/src/ui/widgets/comic_cover.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  void onChoosedComic(ComicCover comicCover, String part) {
    var model = Provider.of<ComicDetailPageModel>(context);
    model.onLoadData(comicCover.id);
    model.setFollow(Provider.of<FollowDao>(context)
        .idFollowedComics
        .contains(comicCover.id));
    model.setLike(
        Provider.of<LikeDao>(context).idLikedComics.contains(comicCover.id));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ComicDetailPage(
          part: part,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<FilterPageModel>(
        builder: (_, model, __) {
          return Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          Text(
                            "Thể loại truyện",
                            style: const TextStyle(fontSize: 16),
                          ),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: model.idType,
                            items: [
                              DropdownMenuItem(
                                child: Text('Không chọn'),
                                value: null,
                              ),
                              ...List.generate(model.types.length, (index) {
                                return DropdownMenuItem(
                                  child: Text('${model.types[index].name}'),
                                  value: model.types[index].id,
                                );
                              }),
                            ],
                            onChanged: (String value) {
                              if (value != model.idType) {
                                model.setIdType(value);
                              }
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            "Tình trạng",
                            style: const TextStyle(fontSize: 16),
                          ),
                          DropdownButton<int>(
                            isExpanded: true,
                            value: model.state,
                            items: [
                              DropdownMenuItem(
                                child: Text('Không chọn'),
                                value: null,
                              ),
                              ...List.generate(states.length, (index) {
                                return DropdownMenuItem(
                                  child: Text('${states[index].value}'),
                                  value: states[index].key,
                                );
                              }),
                            ],
                            onChanged: (int value) {
                              if (value != model.state) {
                                model.setState(value);
                              }
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            "Giới tính",
                            style: const TextStyle(fontSize: 16),
                          ),
                          DropdownButton<int>(
                            isExpanded: true,
                            value: model.gender,
                            items: [
                              DropdownMenuItem(
                                child: Text('Không chọn'),
                                value: null,
                              ),
                              ...List.generate(genders.length, (index) {
                                return DropdownMenuItem(
                                  child: Text('${genders[index].value}'),
                                  value: genders[index].key,
                                );
                              })
                            ],
                            onChanged: (int value) {
                              if (value != model.gender) {
                                model.setGender(value);
                              }
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            "Độ tuổi",
                            style: const TextStyle(fontSize: 16),
                          ),
                          DropdownButton<Age>(
                            isExpanded: true,
                            value: model.age,
                            items: [
                              DropdownMenuItem(
                                child: Text('Không chọn'),
                                value: null,
                              ),
                              ...List.generate(ages.length, (index) {
                                return DropdownMenuItem(
                                  child: Text('${ages[index].value}'),
                                  value: ages[index].key,
                                );
                              }),
                            ],
                            onChanged: (Age value) {
                              if (value != model.age) {
                                model.setAge(value);
                              }
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            "Sắp xếp",
                            style: const TextStyle(fontSize: 16),
                          ),
                          DropdownButton<Sort>(
                            isExpanded: true,
                            value: model.sort,
                            items: [
                              DropdownMenuItem(
                                child: Text('Không chọn'),
                                value: null,
                              ),
                              ...List.generate(sorts.length, (index) {
                                return DropdownMenuItem(
                                  child: Text('${sorts[index].value}'),
                                  value: sorts[index].key,
                                );
                              }),
                            ],
                            onChanged: (Sort value) {
                              if (value != model.sort) {
                                model.setSort(value);
                              }
                            },
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          FlatButton.icon(
                            icon: Icon(Icons.clear),
                            label: Text('Bỏ chọn'),
                            onPressed: model.clear,
                          ),
                          FlatButton.icon(
                            icon: Icon(Icons.filter_list),
                            label: Text('Lọc'),
                            onPressed: model.fetchFilter,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              model.comicCovers.isNotEmpty ? Divider() : Container(),
              model.busy
                  ? Center(
                      child: LinearProgressIndicator(),
                    )
                  : ComicCoverList(
                      comicCovers: model.comicCovers,
                      onChoosedComic: onChoosedComic,
                      part: "filter_page",
                    ),
            ],
          );
        },
      ),
    );
  }
}
