import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  // Todo: Exit app Pop up
  /// SHOW EXIT APP POP UP
  void warningDialog(BuildContext context, String message,
      VoidCallback callback) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("$message"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("YES"),
              onPressed: () {
                callback(); //delete confirmation
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("CLOSE"),
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