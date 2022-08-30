
import 'package:flutter/material.dart';

import '../materialcolors/materialcolors.dart';

void showToast(BuildContext context,String str) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
     SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        str,
        textDirection: TextDirection.rtl,
        style: TextStyle(fontFamily: 'sans', fontSize: 12),
      ),
    ),
  );
}

void showToastExit(BuildContext context,String str) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
       backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Text(
        str,
        textDirection: TextDirection.rtl,
        style: TextStyle(fontFamily: 'sans', fontSize: 12),
      ),
    ),
  );
}

void showToastFile(BuildContext context, String nameFile) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Palette.iconSnack,
          ),
          Container(
            width: 250,
            child: Text(
              "  فایل ${nameFile} اضافه شد ",
              maxLines: 2,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'sans', fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}
void showToastSendTicket(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Palette.iconSnack,
          ),
          Container(
            width: 250,
            child: Text(
              " تیکت با موفقیت ارسال شد ",
              maxLines: 2,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontFamily: 'sans', fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}