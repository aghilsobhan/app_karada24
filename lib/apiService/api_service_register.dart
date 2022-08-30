

import 'dart:convert';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;
import 'package:app_karada24/models/model_register.dart';
import 'package:app_karada24/response/response_register.dart';

class ApiServiceRegister {
  Future<ResponseRegister> register(
      ModelRegister requestModel,) async {
    try {
      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(ConstString.urlSrvRegistering+"RegisterGuest"),
          body: bodyIs,
          headers: {
            "content-type": "application/json"
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 400) {
        return ResponseRegister.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}