import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../widgets/open_image.dart';
import '../../widgets/open_pdf.dart';
import '../../widgets/show_toast.dart';
Future<bool> openFile(Directory directory,String fileImg,List<dynamic>? file,BuildContext context) async {
  try {
    String fileExtension = p.extension(fileImg);
    if (await directory.exists()) {
      file = directory.listSync();
      file.forEach((element) {
          debugPrint("element  "+element.runtimeType.toString());
          debugPrint("directory  "+element.runtimeType.toString());
          debugPrint("fileImg  "+element.runtimeType.toString());
          debugPrint("file  "+element.runtimeType.toString());
        if (element.toString().contains(fileImg.toString())) {
          if(fileExtension.contains("png")||fileExtension.contains("jpg")||fileExtension.contains("jpeg")){
            ShowImageFile(element.path,context);
          }else
          if(fileExtension.contains(".pdf")){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return ShowPdfFile(file: element.path);
                }));

          }else {
            showToast(context,"مشکل در خواندن فایلی");
          }
        }
      });

      return true;
    } else {
      return false;
    }
  } catch (e) {
    debugPrint("fileImg  " + e.toString());
    return false;
  }
}