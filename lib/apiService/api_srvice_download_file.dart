import 'dart:convert';
import 'package:app_karada24/models/model_download_file.dart';
import 'package:app_karada24/response/response_download_file.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceDownloading{

  Future<ResponseDownloadFile> number(
      ModelDownloadFile requestModel,String token) async {
    try {

      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(ConstString.urlSrvUpload+"downFile"),
          body: bodyIs,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200 || response.statusCode == 400) {

        return ResponseDownloadFile.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}