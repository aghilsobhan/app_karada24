import 'dart:io';
import 'package:flutter/material.dart';

void ShowImageFile(String file,BuildContext context){
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context:context,
      backgroundColor: Colors.black54,
      builder: (BuildContext context) {
        return ListView(
          children: [
            SizedBox(height:35,),
            Center(
              child: Image.file(
                File(file.toString()),
                height: 500,
                width: 400,
                alignment: Alignment.center,

              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      });
}
