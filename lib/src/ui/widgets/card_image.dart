// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imageLink;
  final bool isDownloaded;

  CardImage({Key key, @required this.imageLink, this.isDownloaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: isDownloaded == true
          ? Image.file(
              File(imageLink),
              fit: BoxFit.fill,
            )
          : FadeInImage.assetNetwork(
              image: imageLink,
              placeholder: 'assets/loading.jpg',
              fit: BoxFit.fill,
            ),
      elevation: 5,
    );
  }
}
