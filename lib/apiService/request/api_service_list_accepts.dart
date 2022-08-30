import 'dart:convert';
import 'package:app_karada24/response/request/response_list_submited.dart';
import '../../value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceListSubmitted{
  Future<ResponseListSubmitted> listAccept(String token,int orgId,int userId) async{
    // final bodyIs = jsonEncode(modelRequest.toJson());
    final response=await http.get(
        Uri.parse(ConstString.urlSrvRegistering+"GetUserRequest?userId=$userId&orgId=$orgId"),
        // body:bodyIs,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);

        return ResponseListSubmitted.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}