

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../materialcolors/materialcolors.dart';
class ShowPdfFile extends StatelessWidget {
  final String file;
  const ShowPdfFile({Key? key,required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.file(
          File(file)),
      appBar: AppBar(

        backgroundColor: Palette.bottomNavUnBack,
        toolbarHeight: 46.0,
        leadingWidth: 46,// double
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
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 6),
              child: Align(alignment: Alignment.center,
                  child: Text("pdf",
                    style: TextStyle(color: Colors.black,
                        fontFamily: "sans",
                        fontWeight: FontWeight.bold),
                  )
              )
          )
        ],
      ),
    );
  }
}


// void ShowPdfFile(String file,BuildContext context){
//   showModalBottomSheet(
//       isScrollControlled: true,
//       isDismissible: false,
//       context:context,
//       backgroundColor: Colors.black54,
//       builder: (BuildContext context) {
//         return
//           PDFView(
//             filePath: file,
//             enableSwipe: true,
//             swipeHorizontal: true,
//             autoSpacing: false,
//             pageFling: false,
//             onRender: (_pages) {
//             },
//             onError: (error) {
//               print(error.toString());
//             },
//             onPageError: (page, error) {
//               print('$page: ${error.toString()}');
//             },
//           );
//       });
// }



