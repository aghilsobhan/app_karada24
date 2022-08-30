//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:app_karada24/value/const_string.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// import '../../models/model_upload_file.dart';
// class MyPage extends StatefulWidget {
//   const MyPage({Key? key}) : super(key: key);
//
//   @override
//   _MyPageState createState() => _MyPageState();
// }
//
// class _MyPageState extends State<MyPage> {
//   int _total = 0,
//       _received = 0;
//   late http.StreamedResponse _response;
//   File? _image;
//   final List<int> _bytes = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         label: Text('${_received ~/ 1024}/${_total ~/ 1024} KB'),
//         icon: Icon(Icons.file_download),
//         onPressed: main,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: SizedBox.fromSize(
//             size: Size(400, 300),
//             child: _image == null ? Placeholder() : Image.file(
//                 _image!, fit: BoxFit.fill),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _downloadImage() async {
//     _response = await http.Client()
//         .send(http.Request('GET', Uri.parse(
//         'https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg')));
//     _total = _response.contentLength ?? 0;
//
//     _response.stream.listen((value) {
//       setState(() {
//         print(value);
//         _bytes.addAll(value);
//         _received += value.length;
//       });
//     }).onDone(() async {
//       final file = File(
//           '${(await getApplicationDocumentsDirectory()).path}/image.png');
//       await file.writeAsBytes(_bytes);
//       setState(() {
//         _image = file;
//       });
//     });
//   }
//
//   main() async {
//     String url =
//         'https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg';
//
//     print(await apiRequest(url));
//   }
//
//   Future<String> apiRequest(String url) async {
//     HttpClient httpClient = new HttpClient();
//     HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
//     request.headers.set('content-type', 'application/json');
//     HttpClientResponse response = await request.close();
//     // todo - you should check the response.statusCode
//     String reply = await response.(utf8.decoder).join();
//     httpClient.close();
//     return reply;
//   }
// //   Future<void> number(ModelUploadFile requestModel,String? token) async {
// //     try {
// //       HttpClient httpClient = new HttpClient();
// //       final bodyIs = jsonEncode(requestModel.toJson());
// //       HttpClientRequest request = await httpClient.postUrl(Uri.parse(ConstString.urlSrvUpload+"upFile"));
// //       request.headers.set('content-type', 'application/json');
// //       request.headers.set('Authorization', "Bearer $token");
// //
// //
// //       final _response = await http.post(
// //           Uri.parse(ConstString.urlSrvUpload+"upFile"),
// //           body: bodyIs,
// //           headers: {
// //             "content-type": "application/json",
// //             "Authorization": "Bearer $token"
// //           });
// //       _total = _response.contentLength ?? 0;
// //       _response.stream.listen((value) {
// //         setState(() {
// //           print(value);
// //           _bytes.addAll(value);
// //           _received += value.length;
// //         });
// //       }).onDone(() async {
// //         setState(() {
// //           print("ok ok");
// //           print("_received ok"+_received.toString());
// //           print("_bytes ok"+_bytes.toString());
// //         });
// //       });
// //   }
// // }
//
// }