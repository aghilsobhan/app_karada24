import 'dart:convert';

import 'package:app_karada24/models/requests/model_request.dart';

import '../../response/request/response_list_request.dart';
import '../../value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceListRequest{
  Future<ResponseListRequest> listRequest(String token,int orgId,int userId) async{
   // final bodyIs = jsonEncode(modelRequest.toJson());
    final response=await http.get(
        Uri.parse(ConstString.urlSrvRegistering+"GetNonRequestedUsers?userId=$userId&orgId=$orgId"),
       // body:bodyIs,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);

        return ResponseListRequest.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}