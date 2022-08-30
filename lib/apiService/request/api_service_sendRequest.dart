import 'dart:convert';
import 'package:app_karada24/models/requests/model_sendrequest.dart';
import 'package:app_karada24/response/request/response_send_request.dart';
import '../../value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceSendRequest{
  Future<ResponseSendRequest> sendRequest(String? token,ModelSendRequests modelSendRequests) async{

    final bodyIs = jsonEncode(modelSendRequests.toJson());
    final response=await http.post(
        Uri.parse(ConstString.urlSrvRegistering+"AddRequest"),
         body:bodyIs,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token",
          'Charset': 'utf-8'
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        return ResponseSendRequest.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}