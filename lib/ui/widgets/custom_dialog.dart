import 'package:flutter/material.dart';

custonDialog(
    {BuildContext context,
    String title,
    String description,
    bool btn1 = false,
    Function onYes,
    Function onNo}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            height: 90,
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: onYes,
              child: Text(
                btn1 ? 'Ok' : 'Yes',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            FlatButton(
              onPressed: onNo,
              child: Text(
                btn1 ? '' : 'No',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      });
}
