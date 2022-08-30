import 'dart:convert';
import 'package:app_karada24/response/response_reply_all.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceAllReplyTickets{

  Future<ResponseReciveAllReply> listTickets(int OwnerType,int TckId,String? token) async{
    String url=ConstString.urlSrvTickets+"GetReplies?TckId=${TckId}&OwnerType=${OwnerType}";
    final response=await http.get(
        Uri.parse(url),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
       // print(jsonresponse);
        return  ResponseReciveAllReply.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}