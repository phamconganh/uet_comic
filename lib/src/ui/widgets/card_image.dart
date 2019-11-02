// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imageLink;

  CardImage({Key key, @required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: FadeInImage.assetNetwork(
        image: imageLink,
        placeholder: 'assets/loading.jpg',
        fit: BoxFit.fill,
      ),
      // child: CachedNetworkImage(
      //   imageUrl: imageLink,
      //   placeholder: (context, url) => CircularProgressIndicator(),
      //   errorWidget: (context, url, error) => Icon(Icons.error),
      // ),
      elevation: 5,
    );
  }
}
