// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uet_comic/src/core/models/comic_cover.dart';

class SafeImage extends StatelessWidget {
  final String imageLink;
  final bool isDownloaded;

  SafeImage({
    Key key,
    @required this.imageLink,
    this.isDownloaded,
  })  : assert(imageLink != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildImage;
  }

  // can chinh lai bang cache
  Widget get _buildImage {
    Widget image;
    try {
      image = isDownloaded == true
          ? Image.file(
              File(imageLink),
              fit: BoxFit.fill,
            )
          : FadeInImage.assetNetwork(
              image: imageLink,
              placeholder: 'assets/loading.jpg',
              fit: BoxFit.fill,
            );
    } catch (e) {
      image = Image.asset('assets/warning.jpg');
    }
    return image;
  }
}

class ComicCoverImage extends StatelessWidget {
  final ComicCover comicCover;
  final String part;
  final bool isDownloaded;

  ComicCoverImage({
    Key key,
    @required this.comicCover,
    this.part,
    this.isDownloaded,
  })  : assert(comicCover != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _buildTagFromIdAndPart(comicCover.id, part),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SafeImage(
          imageLink: comicCover.imageLink,
          isDownloaded: isDownloaded,
        ),
        elevation: 5,
      ),
    );
    // return Card(
    //   semanticContainer: true,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   child: SafeImage(
    //     imageLink: comicCover.imageLink,
    //     isDownloaded: isDownloaded,
    //   ),
    //   elevation: 5,
    // );
  }

  String _buildTagFromIdAndPart(String id, String part) {
    if (id == null) id = "id";
    if (part == null) part = "part";
    String tag = id + "_" + part;
    return tag;
  }
}
