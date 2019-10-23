import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imageLink;

  CardImage({Key key, this.imageLink}) : super(key: key);

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
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      elevation: 5,
    );
  }
}
