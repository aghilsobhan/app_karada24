import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:app_karada24/utility/snackbar_error.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// class CheckFiles{
//   late Directory directory;
//   List<dynamic>? file;
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
//   Future<bool> newDirectory(BuildContext context,String content, String name) async {
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
//           return false;
//         }
//       } else {
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
//
//           return false;
//         }
//       }
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         try {
//           if (await directory.exists()) {
//             final decodedBytes = base64Decode(content);
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
//             return true;
//           } else {
//             print("e.toString()");
//             return false;
//           }
//         } catch (e) {
//           print(e.toString());
//           return false;
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }
//   Future<bool> directoryExists(BuildContext context)async{
//     late bool directoryExist;
//     var androidInfo = await DeviceInfoPlugin().androidInfo;
//     var release = androidInfo.version.release;
//     if (release.contains(".")) {
//       int idx = release.indexOf(".");
//       release = release.substring(0, idx).trim();
//     }
//     if (Platform.isAndroid && int.parse(release).round() <= 10) {
//       if (await _requestPermission(Permission.storage)) {
//         directory = (await getExternalStorageDirectory())!;
//         String newPath = "";
//         List<String> paths = directory.path.split("/");
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
//           directoryExist=true;
//           // setState(() {
//           //   setDateListFiles = _setData();
//           // });
//         }
//         if (!await directory.exists()) {
//           await directory.create(recursive: true);
//           directoryExist=true;
//           // setDateListFiles = _setData();
//         }
//       }
//     }else{
//       if (await _requestPermission(Permission.storage) &&
//           await _requestPermission(Permission.accessMediaLocation) &&
//           await _requestPermission(Permission.manageExternalStorage)) {
//         directory = (await getExternalStorageDirectory())!;
//         String newPath = "";
//         print(directory);
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
//           directoryExist=true;
//           // setState(() {
//           //   setDateListFiles = _setData();
//           // });
//         }
//         if (!await directory.exists()) {
//           await directory.create(recursive: true);
//           directoryExist=true;
//           // setDateListFiles = _setData();
//         }
//       } else {
//         SnackError(context, "خطا در ذخیره فایل");
//         directoryExist=false;
//       }
//     }
//     return directoryExist;
//   }
//   Future<bool> HasFile(String name,BuildContext context)async{
//     return await directory.list().any((element) => element.path.split('/').last==name);
//   }
//   Future<bool> openFile(String fileImg,BuildContext context) async {
//     try {
//       debugPrint("fileImg  " + fileImg);
//       if (await directory.exists()) {
//         file = directory.listSync();
//         file?.forEach((element) {
//           //  debugPrint("element  "+element.runtimeType.toString());
//           if (element.toString().contains(fileImg.toString())) {
//             OpenFile.open(element.path);
//             debugPrint("elementcount  " + element.toString());
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
// }