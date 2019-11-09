import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uet_comic/src/core/models/chapter.dart';
import 'package:uet_comic/src/ui/shared/type_def.dart';

class BottomChapterBar extends StatefulWidget {
  final List<Chapter> chapters;
  final VoidCallback goHome;
  final VoidCallback reportChapter;
  final VoidCallback changeLight;
  final VoidCallback like;
  final VoidCallback nextChapter;
  final VoidCallback previousChapter;
  final IntCallback chooseIndexChapter;
  final int currentIndex;

  BottomChapterBar({
    Key key,
    this.chapters,
    this.goHome,
    this.reportChapter,
    this.changeLight,
    this.like,
    this.nextChapter,
    this.previousChapter,
    this.chooseIndexChapter,
    this.currentIndex,
  }) : super(key: key);

  @override
  _BottomChapterBarState createState() => _BottomChapterBarState();
}

class _BottomChapterBarState extends State<BottomChapterBar> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    _value = widget.currentIndex;
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     topLeft: const Radius.circular(40.0),
      //     topRight: const Radius.circular(40.0),
      //   ),
      //   color: Theme.of(context).bottomAppBarColor,
      // ),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 45,
          maxHeight: 50,
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: widget.goHome != null ? widget.goHome : () {},
              ),
              IconButton(
                icon: Icon(Icons.warning),
                onPressed:
                    widget.reportChapter != null ? widget.reportChapter : () {},
              ),
              IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed: widget.previousChapter != null
                    ? widget.previousChapter
                    : () {},
              ),
              DropdownButton<int>(
                value: _value,
                items: List.generate(widget.chapters.length, (index) {
                  return DropdownMenuItem(
                    child: Center(
                      child: Text('Chương ${widget.chapters[index].name}'),
                    ),
                    value: index,
                  );
                }),
                onChanged: (int value) {
                  if (value != _value) {
                    setState(() {
                      _value = value;
                    });
                    if(widget.chooseIndexChapter != null) {
                      widget.chooseIndexChapter(value);
                    }
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed:
                    widget.nextChapter != null ? widget.nextChapter : () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.lightbulb),
                onPressed:
                    widget.changeLight != null ? widget.changeLight : () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.heart),
                onPressed: widget.like != null ? widget.like : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
