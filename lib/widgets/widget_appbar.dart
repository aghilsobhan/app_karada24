
import 'package:flutter/material.dart';

import '../materialcolors/materialcolors.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  MyAppBar({
    required this.title,
});
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.bottomNavUnBack,
      toolbarHeight: 40.0,
      elevation: 0.0,
      leadingWidth: 40,// double
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width:30,
            height: 30,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25)),
            child: const Icon(
              Icons.close,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 6),
            child: Align(alignment: Alignment.center,
                child: Text(title,
                  style: TextStyle(color: Colors.black,
                      fontFamily: "sans",
                      fontWeight: FontWeight.bold),
                )
            )
        )
      ],
    );
  }
}