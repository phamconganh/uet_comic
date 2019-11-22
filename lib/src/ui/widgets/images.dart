// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:flutter/material.dart';

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

class HeroImage extends StatelessWidget {
  final String imageLink;
  final String tag;
  final bool isDownloaded;

  HeroImage({
    Key key,
    @required this.imageLink,
    @required this.tag,
    this.isDownloaded,
  })  : assert(imageLink != null),
        assert(tag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SafeImage(
          imageLink: imageLink,
          isDownloaded: isDownloaded,
        ),
        elevation: 5,
      ),
    );
  }
}

String buildTagFromIdAndPart(String id, String part) {
  if (id == null) id = "id";
  if (part == null) part = "part";
  return id + "_" + part;
}
