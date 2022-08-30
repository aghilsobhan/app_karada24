import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app_karada24/utility/mange_files/manage_files.dart';
import 'package:app_karada24/widgets/open_pdf.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_srvice_download_file.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../apiService/api_service_get_files.dart';
import '../../materialcolors/materialcolors.dart';
import '../../models/model_download_file.dart';
import '../../models/moder_recive_files.dart';
import '../../response/response_get_files.dart';
import '../../widgets/open_image.dart';
import 'package:path/path.dart' as p;

import '../../widgets/show_toast.dart';

class UploadFileTicketing extends StatefulWidget {
  final String token;
  final int? ownerId;
  UploadFileTicketing(this.token, this.ownerId, {Key? key}) : super(key: key);

  @override
  _UploadFileTicketingState createState() => _UploadFileTicketingState();
}

class _UploadFileTicketingState extends State<UploadFileTicketing> {
  late Future<void> setDateListFiles;
  List<DataUpFile> listFiles = [];
  bool isLoading = false;
  bool isLoadingDownload = false;
  String? _progressString ="0";
  int indexFile = 0;
  List<dynamic>? file;
  late Directory directory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40, right: 13, left: 13),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.bottomNavUnBack,
          border: Border.all(color: Palette.gradient2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("فایلها",
                      style: TextStyle(
                          fontFamily: 'sans',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30.0,
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
                ],
              ),
            ),
            const Divider(
              height: 0.3,
              color: Palette.gradient2,
            ),
            SizedBox(
              height: 10,
            ),
            ListFiles(token: widget.token,ownerName:"ticket" ,ownerId:widget.ownerId ,)
          ],
        ),
      ),
    );
  }

  // Widget widgetListFiles() {
  //   return !isLoading
  //       ? listFiles.length != 0
  //           ? Container(
  //               padding: EdgeInsets.all(8),
  //               child: GridView.builder(
  //                   shrinkWrap: true,
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisSpacing: 10,
  //                           mainAxisSpacing: 10,
  //                           crossAxisCount: 4),
  //                   itemCount: listFiles.length,
  //                   itemBuilder: (BuildContext ctx, index) {
  //
  //                     return GestureDetector(
  //                       onTap: () {
  //                         listFiles[index].isDownload == true?  openFile(listFiles[index]
  //                             .fileName
  //                             .toString()): setState(() {
  //                           isLoadingDownload = true;
  //                           indexFile = index;
  //                           listFiles[index]
  //                               .isDownload = true;
  //                         });
  //
  //                         downloadFiles(listFiles[index]
  //                             .fileId as int);
  //                       },
  //                       child: Container(
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(5),
  //                           child: Stack(
  //                             children: [
  //                               Directionality(
  //                                 textDirection: TextDirection.rtl,
  //                                 child: Text(
  //                                   listFiles[index].fileName.toString(),
  //                                   maxLines: 2,
  //                                   style: const TextStyle(
  //                                       fontSize: 10,
  //                                       fontFamily: 'sans',
  //                                       color: Colors.white),
  //                                 ),
  //                               ),
  //                               const Padding(
  //                                 padding: EdgeInsets.only(bottom: 20),
  //                                 child: Align(
  //                                     alignment: Alignment.bottomCenter,
  //                                     child: Divider(
  //                                       color: Colors.white,
  //                                     )),
  //                               ),
  //                               Align(
  //                                   alignment: Alignment.bottomCenter,
  //                                   child: isLoadingDownload &&
  //                                           index == indexFile
  //                                       ? const SizedBox(
  //                                           height: 20,
  //                                           width: 20,
  //                                           child: CircularProgressIndicator(
  //                                             color: Colors.white,
  //                                             strokeWidth: 1,
  //                                           ))
  //                                       : listFiles[index].isDownload == true
  //                                           ? GestureDetector(
  //                                               onTap: () {
  //
  //                                               },
  //                                               child: const Icon(
  //                                                 Icons.check,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             )
  //                                           : GestureDetector(
  //                                               onTap: () async {
  //                                                 //print(release);
  //
  //                                               },
  //                                               child: const Icon(
  //                                                 Icons.download,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ))
  //                             ],
  //                           ),
  //                         ),
  //                         decoration: BoxDecoration(
  //                             color: Palette.primaryColorD,
  //                             borderRadius: BorderRadius.circular(15)),
  //                       ),
  //                     );
  //                   }),
  //             )
  //           : Center(
  //               child: Column(
  //                 children: [
  //                   Image.asset(
  //                     "images/null.png",
  //                     height: 100,
  //                     width: 100,
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Text(
  //                     "فایلی برای این تیکت وجود ندارد",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontFamily: "sans",
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //       : Center(
  //           child: SizedBox(
  //             child: CircularProgressIndicator(
  //               strokeWidth: 1,
  //             ),
  //             height: 25.0,
  //             width: 25.0,
  //           ),
  //         );
  // }

  @override
  void initState() {
  //  directoryExists();
    //  _listofFiles();
    super.initState();
  }
//
//   Future<void> _setData() async {
//
//
//     ModelReciveFiles modelReciveFiles = ModelReciveFiles(
//         ownerId: widget.ownerId as int,
//         ownerName: "ticket",
//         serviceName: "ticketing");
//     ApiServiceGetFile apiService = ApiServiceGetFile();
//
//     await apiService.number(modelReciveFiles, widget.token).then(
//       (value) async {
//         try {
//           if (value.data != null) {
//             try {
//               listFiles = value.data!;
//
//               listFiles.forEach((element) {
//                 print(element.fileName.toString());
//               HasFile(element.fileName.toString()).then((value)  {
//                 setState(() {
//
//                   element.isDownload=value;
//                 });
//
//               });
//               });
//                   setState(() {
//                     isLoading=false;
//                   });
//               //check files
//             } catch (e) {
//               setState(() {
//                 isLoading=false;
//               });
//               SnackError(context, "خطای برقراری ارتباط");
//             }
//           } else {}
//         } catch (e) {
//           setState(() {
//             isLoading = false;
//           });
//           SnackError(context, e.toString());
//         }
//       },
//     ).catchError((e) {
//       setState(() {
//         isLoading = false;
//       });
//       SnackError(context, e.toString());
//     });
//   }
//
//   void downloadFiles(int fileId) async {
//     print("fileId " + fileId.toString());
//     ModelDownloadFile modelDownloadFile = ModelDownloadFile(fileId: fileId);
//     ApiServiceDownloading apiService = ApiServiceDownloading();
//     await apiService.number(modelDownloadFile, widget.token).then(
//       (value) async {
//         try {
//           // ignore: unnecessary_null_comparison
//           if (value.data != null) {
// // print(value.isSuccess);
// //        await   saveVideo(value.data.fileContent,value.data.fileName).then((value) {
// //             print(value);
// //               setState(() {
// //                 isLoadingDownload = false;
// //                 isLoading = false;
// //               });
// //               OpenFile.open(value);
// //           } );
// //             saveFilePermanently(value.data.fileContent, value.data.fileName)
// //                 .then((value) {
// //               setState(() {
// //                 isLoadingDownload = false;
// //                 isLoading = false;
// //               });
// //             });
//             _downloadNetworkImage(value.data.fileContent as String);
//             newDirectory(value.data.fileContent, value.data.fileName);
//           } else {
//
//           }
//         } catch (e) {
//           SnackError(context, e.toString());
//           setState(() {
//             isLoadingDownload = false;
//             isLoading = false;
//           });
//         }
//       },
//     ).catchError((e) {
//       SnackError(context, e.toString());
//       setState(() {
//         isLoadingDownload = false;
//         isLoading = false;
//       });
//     });
//   }
//
//
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   void SnackError(BuildContext context, String str) {
//     final snackBar = SnackBar(
//       behavior: SnackBarBehavior.floating,
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const Icon(
//             Icons.error_outline,
//             size: 16,
//             color: Colors.white,
//           ),
//           const SizedBox(
//             width: 13,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 str,
//                 maxLines: 2,
//                 style: const TextStyle(fontSize: 12, fontFamily: 'sans'),
//               ),
//             ),
//           )
//         ],
//       ),
//       backgroundColor: Palette.error,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   Future<bool> newDirectory(String? content, String? name) async {
//     var androidInfo = await DeviceInfoPlugin().androidInfo;
//     var release = androidInfo.version.release;
//     if (release.contains(".")) {
//       int idx = release.indexOf(".");
//       release = release.substring(0, idx).trim();
//     }
//     print(release);
//     //
//     try {
//       if (Platform.isAndroid && int.parse(release).round() <= 10) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = (await getExternalStorageDirectory())!;
//           String newPath = "";
//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/CRMApp";
//           directory = Directory(newPath);
//         } else {
//           SnackError(context, "خطا در ذخیره فایل");
//           setState(() {
//             isLoadingDownload = false;
//             isLoading = false;
//           });
//           return false;
//         }
//       }
//       else {
//         if (await _requestPermission(Permission.storage) &&
//             await _requestPermission(Permission.accessMediaLocation) &&
//             await _requestPermission(Permission.manageExternalStorage)) {
//           directory = (await getExternalStorageDirectory())!;
//           String newPath = "";
//           print(directory);
//           List<String> paths = directory.path.split("/");
//           print(directory);
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/CRMApp";
//           directory = Directory(newPath);
//           // directory.list().toList().then((filesList) => print(filesList));
//           // print(directory);
//         } else {
//           SnackError(context, "خطا در ذخیره فایل");
//           setState(() {
//             isLoadingDownload = false;
//             isLoading = false;
//           });
//           return false;
//         }
//       }
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         try {
//           if (await directory.exists()) {
//             final decodedBytes = base64Decode(content!);
//             File fileImg = File('${directory.path}/$name');
//             fileImg.writeAsBytesSync(List.from(decodedBytes));
//             // file=directory.listSync();
//             //  debugPrint("fileImg  "+fileImg.path);
//             //  file?.forEach((element) {
//             // //  debugPrint("element  "+element.runtimeType.toString());
//             //    if(element.toString().contains(fileImg.toString())){
//             //      debugPrint("element  "+element.toString());
//             //      OpenFile.open(element.path);
//             //      setState(() {
//             //        iconDownload=true;
//             //      });
//             //   //   debugPrint("elementcount  "+element.toString());
//             //    }
//             //  });
//             // OpenFile.open( directory.listSync()[3].path);
//             //   debugPrint(" Directory(directory1/RPSApp).listSync()"+file.toString());
//             //   File saveFile = File(directory.path + "/$fileName");
//             // await dio.download(url, saveFile.path,
//             //     onReceiveProgress: (value1, value2) {
//             //       setState(() {
//             //         progress = value1 / value2;
//             //       });
//             //     });
//             setState(() {
//               isLoadingDownload = false;
//               isLoading = false;
//             });
//           } else {
//             print("e.toString()");
//           }
//         } catch (e) {
//           print(e.toString());
//           setState(() {
//             isLoadingDownload = false;
//             isLoading = false;
//           });
//         }
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoadingDownload = false;
//         isLoading = false;
//       });
//     }
//     return false;
//   }
//
//    directoryExists()async{
//      setState(() {
//        isLoading = true;
//      });
//     var androidInfo = await DeviceInfoPlugin().androidInfo;
//     var release = androidInfo.version.release;
//     if (release.contains(".")) {
//       int idx = release.indexOf(".");
//       release = release.substring(0, idx).trim();
//     }
//     if (Platform.isAndroid && int.parse(release).round() <= 10) {
//       if (await _requestPermission(Permission.storage)) {
//         try{
//           directory = (await getExternalStorageDirectory())!;
//           String newPath = "";
//           print("directory   "+directory.toString());
//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               ;
//             }
//           }
//           newPath = newPath + "/CRMApp";
//           directory = Directory(newPath);
//           if (await directory.exists()) {
//
//             setState(() {
//               setDateListFiles = _setData();
//             });
//           }
//           if (!await directory.exists()) {
//             await directory.create(recursive: true);
//             setDateListFiles = _setData();
//           }
//
//         }catch(e){
//           print(e.toString());
//         }
//
//
//       }
//     }else{
//       if (await _requestPermission(Permission.storage) && await _requestPermission(Permission.accessMediaLocation) && await _requestPermission(Permission.manageExternalStorage)) {
//         directory = (await getExternalStorageDirectory())!;
//         String newPath = "";
//         print("directory   "+directory.toString());
//         List<String> paths = directory.path.split("/");
//         print(directory);
//         for (int x = 1; x < paths.length; x++) {
//           String folder = paths[x];
//           if (folder != "Android") {
//             newPath += "/" + folder;
//           } else {
//             break;
//           }
//         }
//         newPath = newPath + "/CRMApp";
//         directory = Directory(newPath);
//         if (await directory.exists()) {
//
//           setState(() {
//             setDateListFiles = _setData();
//           });
//         }
//         if (!await directory.exists()) {
//           await directory.create(recursive: true);
//           setDateListFiles = _setData();
//         }
//       } else {
//         print("directory   "+directory.toString());
//         SnackError(context, "خطا در ذخیره فایل");
//
//       }
//     }
//   }
// Future<bool> HasFile(String name)async{
//   return await directory.list().any((element) {
//     print(element.toString());
//    return element.path.split('/').last==name;
//   });
// }
//   Future<bool> openFile(String fileImg) async {
//     try {
//       String fileExtension = p.extension(fileImg);
//       debugPrint("fileImg  " + fileImg);
//       debugPrint("fileExtension  " + fileExtension);
//       print(directory);
//       if (await directory.exists()) {
//         file = directory.listSync();
//         file?.forEach((element) {
//           //  debugPrint("element  "+element.runtimeType.toString());
//           if (element.toString().contains(fileImg.toString())) {
//             if(fileExtension.contains("png")||fileExtension.contains("jpg")||fileExtension.contains("jpeg")){
//               ShowImageFile(element.path,context);
//             }else
//               if(fileExtension.contains(".pdf")){
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) {
//                       return ShowPdfFile(file: element.path);
//                     }));
//
//               }else {
//                 showToast(context,"مشکل در خواندن فایلی");
//               }
//
//           }
//         });
//
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       debugPrint("fileImg  " + e.toString());
//       return false;
//     }
//   }
//   Future<Null> _downloadNetworkImage(String url) async {
//     Dio dio = Dio();
//     try {
//       var dir = await getTemporaryDirectory();
//       print(dir);
//
//
//           SnackBar(content: Text("Downloading image. Please wait..."));
//       await dio.download("https://i.stack.imgur.com/cDiG8.png", '${dir.path}/image.jpeg',
//           onReceiveProgress: (rec, total) {
//             setState(() {
//               isLoadingDownload = true;
//               _progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
//               print(_progressString);
//               if (_progressString == "100%") {
//                 SnackBar(content: Text("Next Action..."));
//                 // NextAction();
//               }
//             });
//           });
//     } catch (exp) {
//       print(exp);
//     }
//   }
// Future<String> saveVideo(String file,String name) async{
//   try{
//
//     final decodedBytes = base64Decode(file);
//     if (await directory.exists()) {
//       File fileImg = File('${directory.path}/$name');
//       fileImg.writeAsBytesSync(List.from(decodedBytes));
//       OpenFile.open(fileImg.path);
//       // file=directory.listSync();
//       //  debugPrint("fileImg  "+fileImg.path);
//       //  file?.forEach((element) {
//       // //  debugPrint("element  "+element.runtimeType.toString());
//       //    if(element.toString().contains(fileImg.toString())){
//       //      debugPrint("element  "+element.toString());
//       //      OpenFile.open(element.path);
//       //      setState(() {
//       //        iconDownload=true;
//       //      });
//       //   //   debugPrint("elementcount  "+element.toString());
//       //    }
//       //  });
//       // OpenFile.open( directory.listSync()[3].path);
//       //   debugPrint(" Directory(directory1/RPSApp).listSync()"+file.toString());
//       //   File saveFile = File(directory.path + "/$fileName");
//       // await dio.download(url, saveFile.path,
//       //     onReceiveProgress: (value1, value2) {
//       //       setState(() {
//       //         progress = value1 / value2;
//       //       });
//       //     });
//       return fileImg.path;
//     }else{
//       return "";
//     }
//   }catch(e){
//     print(e.toString());
//     return "";
//
//   }
//
// }
}
