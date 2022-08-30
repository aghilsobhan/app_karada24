import 'dart:io';

import '../../apiService/api_srvice_download_file.dart';
import '../../models/model_download_file.dart';
import 'new_diewctory.dart';

Future<bool> downloadFiles(int fileId,String token,Directory directory) async {
  bool retValue=false;
  ModelDownloadFile modelDownloadFile = ModelDownloadFile(fileId: fileId);
  ApiServiceDownloading apiService = ApiServiceDownloading();
  await apiService.number(modelDownloadFile, token).then((value) async {
      try {
        // ignore: unnecessary_null_comparison
        if (value.data!=null) {
          newDirectory(value.data.fileContent as String,value.data.fileName as String,directory).then((value) {
            retValue= value;
          });

        } else {
          retValue= false;
        }
      } catch (e) {
        print("download files e1");
        retValue= false;
      }
    },
  ).catchError((e) {
   print("download files e2");
   retValue= false;
  });
  return retValue;
}