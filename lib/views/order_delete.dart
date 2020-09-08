import 'package:flutter/material.dart';

class OrderDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure, you want to delete this precious order?'),
      actions: <Widget>[
        FlatButton(
          child: Text('YES'),
          onPressed: (){
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('NO'),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        )
      ]

    );
  }
}
