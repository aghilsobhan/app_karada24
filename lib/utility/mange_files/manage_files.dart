import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../apiService/api_service_get_files.dart';
import '../../materialcolors/materialcolors.dart';
import '../../models/moder_recive_files.dart';
import '../../response/response_get_files.dart';
import '../snackbar_error.dart';
import 'download_files.dart';
import 'has_file.dart';
import 'open_files.dart';
class ListFiles extends StatefulWidget {
  final String token;
  final int? ownerId;
  final String? ownerName;
  const ListFiles({Key? key, required this.token, this.ownerId, this.ownerName}) : super(key: key);

  @override
  _ListFilesState createState() => _ListFilesState();
}

class _ListFilesState extends State<ListFiles> {
  late Future<void> setDateListFiles;
  List<DataUpFile> listFiles = [];
  bool isLoading = false;
  bool isLoadingDownload = false;
  int indexFile = 0;
  List<dynamic>? file;
  late Directory directory;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? listFiles.length != 0
        ? Container(
      padding: EdgeInsets.all(8),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4),
          itemCount: listFiles.length,
          itemBuilder: (BuildContext ctx, index) {

            return GestureDetector(
              onTap: () {
                listFiles[index].isDownload == true?  openFile(directory,listFiles[index]
                    .fileName.toString(),file,context): setState(() {
                  isLoadingDownload = true;
                  indexFile = index;
                  listFiles[index]
                      .isDownload = true;
                });
                downloadFiles(listFiles[index]
                    .fileId as int,widget.token,directory).then((value) {
                      setState(() {
                        isLoadingDownload=value;
                      });
                });
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          listFiles[index].fileName.toString(),
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'sans',
                              color: Colors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Divider(
                              color: Colors.white,
                            )),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child:
                          isLoadingDownload &&
                              index == indexFile
                              ?
                          const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ))
                             :
                         listFiles[index].isDownload == true
                             ?
                          GestureDetector(
                            onTap: () {

                            },
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )
                             :
                          GestureDetector(
                            onTap: () async {
                              //print(release);

                            },
                            child: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                          )
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Palette.primaryColorD,
                    borderRadius: BorderRadius.circular(15)),
              ),
            );
          }),
    )
        : Center()
        : Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
        height: 25.0,
        width: 25.0,
      ),
    );
  }
  @override
  void initState() {
    directoryExists();
    super.initState();
  }
  directoryExists()async{
    setState(() {
      isLoading = true;
    });
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    if (release.contains(".")) {
      int idx = release.indexOf(".");
      release = release.substring(0, idx).trim();
    }
    if (Platform.isAndroid && int.parse(release).round() <= 10) {
      if (await _requestPermission(Permission.storage)) {
        directory = (await getExternalStorageDirectory())!;
        String newPath = "";
        List<String> paths = directory.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/CRMApp";
        directory = Directory(newPath);
        if (await directory.exists()) {

          setState(() {
            setDateListFiles = _setData();
          });
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
          setDateListFiles = _setData();
        }
      }
    }else{
      if (await _requestPermission(Permission.storage) &&
          await _requestPermission(Permission.accessMediaLocation) &&
          await _requestPermission(Permission.manageExternalStorage)) {
        directory = (await getExternalStorageDirectory())!;
        String newPath = "";
        print(directory);
        List<String> paths = directory.path.split("/");
        print(directory);
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/CRMApp";
        directory = Directory(newPath);
        if (await directory.exists()) {

          setState(() {
            setDateListFiles = _setData();
          });
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
          setDateListFiles = _setData();
        }
      } else {

        setState(() {
          isLoading = false;
        });
        //print(directory);
        SnackError(context, "خطا در ذخیره فایل");

      }
    }
  }
  Future<bool> _requestPermission(Permission permission) async {
    try{
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      }
      return false;
    }catch(e){
      return false;
    }


  }
  Future<void> _setData() async {
    try{
      ModelReciveFiles modelReciveFiles = ModelReciveFiles(
          ownerId: widget.ownerId as int,
          ownerName: widget.ownerName.toString().trim(),
          serviceName: "ticketing");
      ApiServiceGetFile apiService = ApiServiceGetFile();
      await apiService.number(modelReciveFiles, widget.token).then(
            (value) async {
          try {
            if (value.data != null) {
              //  print("file is="+value.data!.length.toString()+"and owner id="+widget.ownerId.toString());

              listFiles = value.data!;
              listFiles.forEach((element) {
                HasFile(element.fileName.toString(),directory).then((value)  {
                  setState(() {
                    element.isDownload=value;
                  });

                });
              });
              setState(() {
                isLoading=false;
              });
            } else {
              print("data is null");
            }
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            SnackError(context, e.toString());
          }
        },
      ).catchError((e) {
        setState(() {
          isLoading = false;
        });
        SnackError(context, e.toString());
      });
    }catch(e){
      print(e.toString());
    }

  }
}
