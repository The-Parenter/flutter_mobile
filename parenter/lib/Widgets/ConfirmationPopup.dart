import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final String title;
  final String message;
  final Function onYesClick;
  final Function onNoClick;

  ConfirmationPopup(
      {this.title, this.message, this.onYesClick, this.onNoClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: new Text("$title"),
        content: new Text("$message"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Yes"),
            onPressed: () {
              onYesClick();
            },
          ),
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              onNoClick();
            },
          ),
        ],
      ),
    );
  }
}