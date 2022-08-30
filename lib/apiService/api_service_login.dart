

import 'dart:convert';
import 'dart:io';
import 'package:app_karada24/models/model_login.dart';
import 'package:app_karada24/response/response_login.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceLogin{
  HttpClient client =  HttpClient();
  Future<ResponseLogin> number(
      ModelLogin requestModel,) async {
    try {
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(ConstString.urlSrvAccount+"login"),
          body: bodyIs,
          headers: {
            "content-type": "application/json"
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 400) {
        return ResponseLogin.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}