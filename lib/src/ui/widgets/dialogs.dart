import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  final String header;
  final String message;
  final String okText;
  final String cancelText;

  Confirm({
    Key key,
    @required this.header,
    @required this.message,
    this.okText,
    this.cancelText,
  })  : assert(header != null),
        assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(header),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(cancelText != null ? cancelText : 'Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text(okText != null ? okText : 'Ok'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
