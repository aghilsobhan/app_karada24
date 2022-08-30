import 'dart:convert';
import 'package:app_karada24/models/model_send_ticket.dart';
import 'package:app_karada24/models/model_upload_file.dart';
import 'package:app_karada24/response/response_upload_file.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceUploadFile{
  static const String uRL = "https://crm.phx.ir/srvupload/api/upFile";
  //static const String uRL = "http://192.168.1.103:8082/api/Ticket";
  static  String token="";

  Future<ResponseUploadFile> number(ModelUploadFile requestModel,String? token) async {
    try {

      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(ConstString.urlSrvUpload+"upFile"),
          body: bodyIs,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $token"
          });
      response.contentLength;
      if (response.statusCode == 200 || response.statusCode == 400) {
        return ResponseUploadFile.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}