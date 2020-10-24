import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

bool checkEmailValid(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

showAlertDialog(BuildContext context, var message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return AlertDialog(
        title: Text("My title"),
        content: Text(message),
      );
    },
  );
}

showFlushBar(BuildContext context, String text) {
  Flushbar flushbar = Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 2),
    backgroundColor: Colors.grey[300],
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue[300],
    ),
    messageText: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
    ),
  );
  flushbar.show(context);
}
