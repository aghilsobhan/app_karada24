
import 'package:flutter/material.dart';

void snackNotification(BuildContext context, String str) {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 5000),
    behavior: SnackBarBehavior.floating,
    content: Container(
        child:
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            str,
            style: const TextStyle(fontSize: 12, fontFamily: 'sans'),
          ),
        )

    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}