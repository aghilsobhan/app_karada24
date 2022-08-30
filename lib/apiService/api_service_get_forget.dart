import 'dart:convert';
import 'package:app_karada24/models/model_error_data.dart';

import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

import '../response/response_forget_password.dart';

class ApiServiceForgetPassword{
  Future<ResponseGetForgetPassword> forgetPassword(String id) async{
    final response=await http.get(
        Uri.parse(ConstString.urlSrvAccount+"ForgotPassword?u="+id.toString()),
        headers: {
          "content-type": "application/json",
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        // print(jsonResponse);
        return  ResponseGetForgetPassword.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}