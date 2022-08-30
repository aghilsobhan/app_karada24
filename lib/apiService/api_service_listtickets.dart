import 'dart:convert';
import 'package:app_karada24/response/response_list_tickets.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceListTickets{
  Future<ResponseGetAllTicket> listTickets(int? userId,int? orgId,int? roleId,String? token) async{
    final response=await http.get(
        Uri.parse(ConstString.urlSrvTicket+"GetUserTickets?userId=${userId}&roleId=${roleId}&orgId=${orgId}"),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      print(token.toString());
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
       // debugPrint(jsonResponse);
        return  ResponseGetAllTicket.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
    throw Exception(e);
    }

  }

}