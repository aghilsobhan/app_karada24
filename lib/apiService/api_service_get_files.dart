import 'dart:convert';
import 'package:app_karada24/models/moder_recive_files.dart';
import 'package:app_karada24/response/response_get_files.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceGetFile{
  Future<ResponseGetFiles> number(
      ModelReciveFiles requestModel,String? token) async {
    try {
      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(ConstString.urlSrvUpload+"GetUpFiles"),
          body: bodyIs,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200 || response.statusCode == 400) {

        return ResponseGetFiles.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}