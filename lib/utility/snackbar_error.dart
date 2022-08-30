import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../materialcolors/materialcolors.dart';

void SnackError(BuildContext context, String str) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 5),

    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.error_outline,
          size: 16,
          color: Colors.white,
        ),
        const SizedBox(
          width: 13,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              str,
              maxLines: 2,
              style: const TextStyle(fontSize: 12, fontFamily: 'sans'),
            ),
          ),
        )
      ],
    ),
    backgroundColor: Palette.error,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}