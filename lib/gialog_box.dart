
import 'package:flutter/material.dart';

class DialogBoxes {
  bool success;
  String title;
  String des;
  DialogBoxes({this.success,this.title,this.des});

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(des),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('خب'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
